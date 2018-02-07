import sys
from PIL import Image
import ImageFilter
import numpy
import PIL.Image
from numpy import array
import copy
import scipy
import os
import mysql.connector
import cStringIO
import base64


WIDTH = 0
HEIGHT = 0
SIZE = 0
TOU = 0

path='C:/Users/Abhi/Desktop/cbir-p/project/images'
ext='.jpg'
def main():
    data=1
    a=[]

    for i in range(1000):
        a.append(data)
        data=data+1

    for k in a:
        imageFile =path+'/a ('+str(k)+').jpg'
        colorString=colorHistogram(imageFile)
        ccv=processColorCoherenceVector(imageFile)
        stringKey=''
        stringValues=''
        keys=ccv.keys()
        vectors=ccv.values()
        for key in keys:
            stringKey='#'.join(key for key in keys)
        for value in vectors:
            stringValues='$'.join(str(value) for value in vectors)

        insert(imageFile,colorString,k,stringKey,stringValues)
         
    print 'insert successful'
def colorHistogram(imageName):
    b=''
    xsize , ysize = Image.open(imageName).size
    im=Image.open(imageName)
    rgb_im = im.convert('RGB')
    redhist=[0]*256
    greenhist=[0]*256
    bluehist=[0]*256
    for y in range(ysize):
        for x in range(xsize):
            r,g,b= rgb_im.getpixel((x,y))
            redhist[r]=redhist[r]+1
            greenhist[g]=greenhist[g]+1
            bluehist[b]=bluehist[b]+1
    result=[]
    result=redhist+greenhist+bluehist
    for r in result:
        b=':'.join(str(r) for r in result)
    return b    
def insert(imgf,st,k,ke,ve):
    db = mysql.connector.connect(user='root', password='abhi',
                              host='localhost',
                              database='cbir')
    blob_value = open(imgf, 'rb').read()
    sql = "INSERT INTO imgdata(images,colhist,id,`key`,`vector`) VALUES(%s,%s,%s,%s,%s)"
    args = (blob_value,st,k,ke,ve)
    cursor=db.cursor()
    cursor.execute(sql,args)
    db.commit()
    db.close()
def compare(r1,r2):
    dist=0
    for r in range(64):
        for g in range(64):
            for b in range(64):
                clr=str(r)+':'+str(g)+':'+str(b)
                dist=dist+abs(r1[clr][0]-r2[clr][0])+abs(r1[clr][1]-r2[clr][1])
                
    return dist
def processColorCoherenceVector(im):
    matrix = convertImageToMatrix(im)
    computeImageDimensions(matrix)
    matrix = computeImageBlur(matrix)
    matrix = computeDiscretization(matrix)
    labelMatrix, connectedComponentTable = computeConnectedComponents(matrix)
    ccv = computeColorCoherenceVector(connectedComponentTable)
    return ccv

import matplotlib.pyplot as plt
def displayImage(image):
    plt.imshow(image)
    plt.show()


def computeColorCoherenceVector(connectedComponentTable):
    tempCCT = {}
    colorCoherenceVector = {}
    
    for key, (label, color, size) in connectedComponentTable.iteritems():
        if(size >= TOU):
            tempCCT[key] = (label, color, size, True)
        else:
            tempCCT[key] = (label, color, size, False)

    for (label, color, size, coherence) in tempCCT.values():
        if(coherence == True):
            clr=':'.join(str(r) for r in color)
            (alpha, beta) = colorCoherenceVector.get(clr, (0, 0))
            colorCoherenceVector[clr] = (alpha + size, beta)
        else:
            clr=':'.join(str(r) for r in color)
            (alpha, beta) = colorCoherenceVector.get(clr, (0, 0))
            colorCoherenceVector[clr] = (alpha, beta + size)

    return colorCoherenceVector

     
def computeConnectedComponents(image):
    connectedComponentTable = {}
    labelImage = copy.deepcopy(image)
    for x in range(0, WIDTH):
        for y in range(0, HEIGHT):
            labelImage[x][y] = None
            
    listOfPixels = computeListOfPixelsInOrder()
    index = 0
    while index < len(listOfPixels):
        (x, y) = listOfPixels[index]
        if(labelImage[x][y] is None):
            for i in range(-1, 2):
                for j in range(-1, 2):
                    nx = x + i
                    ny = y + j
                    if(nx >= 0 and nx < WIDTH and ny >= 0 and ny < HEIGHT and labelImage[x][y] is None and labelImage[nx][ny] is not None and image[x][y] == image[nx][ny]):
                        labelImage[x][y] = labelImage[nx][ny]
                        incrementConnectedComponentsTable(connectedComponentTable, labelImage[nx][ny], image[nx][ny])                        
                        
        if(labelImage[x][y] is None):
            labelImage[x][y] = getNextLabel()
            incrementConnectedComponentsTable(connectedComponentTable, labelImage[x][y], image[x][y])
            
        for i in range(-1, 2):
            for j in range(-1, 2):
                nx = x + i
                ny = y + j
                if(nx >= 0 and nx < WIDTH and ny >= 0 and ny < HEIGHT and labelImage[nx][ny] is None and image[x][y] == image[nx][ny]):
                    labelImage[nx][ny] = labelImage[x][y]
                    incrementConnectedComponentsTable(connectedComponentTable, labelImage[nx][ny], image[nx][ny])
                    listOfPixels.insert(index+1, (nx, ny))
        
        index = index + 1
           
    return labelImage, connectedComponentTable

labelCount = 0;

def getNextLabel():
    global labelCount
    label = str(labelCount)
    labelCount = labelCount + 1
    return label

def incrementConnectedComponentsTable(connectedComponentTable, label, color):
    key = str(label) + "_" + str(color)
    (receivedLabel, receivedColor, receivedSize) = connectedComponentTable.get(key, (label, color, 0))
    connectedComponentTable[key] = (receivedLabel, receivedColor, receivedSize + 1)
    
def computeListOfPixelsInOrder():
    listOfPixels = []
    for x in range(0, WIDTH):
        for y in range(0, HEIGHT):
            listOfPixels.append((x,y))
    return listOfPixels


def computeDiscretization(image):
    for x in range(0, WIDTH):
        for y in range(0, HEIGHT):
            for i in range (3):
                image[x][y][i]=image[x][y][i] / 4
    
    return image


def convertImageToMatrix(inputImageFilename):

    size = Image.open(inputImageFilename).size
    im=Image.open(inputImageFilename)
    rgb_im = im.convert('RGB')
    image=[]
    for x in range(size[0]):
        image.append([])
        for y in range(size[1]):
            inten=list(rgb_im.getpixel((x,y)))
            image[x].append(inten)
    
    return image

def computeImageDimensions(matrix):
    global WIDTH
    global HEIGHT
    global SIZE
    global TOU
    WIDTH = len(matrix)
    HEIGHT = len(matrix[0])
    SIZE = WIDTH * HEIGHT
    TOU = SIZE / 100

def printImage(image):
    for x in range(0, WIDTH):
        for y in range(0, HEIGHT):
            print image[x][y],
        print 
    print
def printCCV(ccv):
    print "Color", "Alpha", "Beta"
    for color, (alpha, beta) in ccv.iteritems():
        print color, alpha, beta  
    print  

def printCCT(connectedComponentTable):
    print "Label", "Color", "Size"
    for (label, color, size) in connectedComponentTable.values():
        print label, color, size
        

def computeImageBlur(image):
    for x in range(0, WIDTH):
        for y in range(0, HEIGHT):
            image[x][y] = averageOfNeighbors(x, y, image)
    return image

def averageOfNeighbors(x, y, image):
    value = [0,0,0]
    count = 0
    for i in range(-1, 2):
        for j in range(-1, 2):
            nx = x + i
            ny = y + j
            if(nx >= 0 and nx < WIDTH and ny >= 0 and ny < HEIGHT):
                for li in range(3):
                    value[li] = value[li] +  image[nx][ny][li]
                count = count + 1
    for li1 in range(3):
        value[li1]=value[li1]/count
    return value

if __name__ == '__main__':
    main()
