import mysql.connector
import sys
from PIL import Image
import cStringIO
import PIL.Image
import ImageFilter
import os
import copy
import scipy
import numpy
from numpy import array

pa='C:/Users/Abhi/Desktop/cbirfinalproject/project/histretrieved/'
path='C:/Users/Abhi/Desktop/cbirfinalproject/project/retrieved/'
ext='.jpg'
    
def main():
    global pa
    global path
    global ext
    for file in os.listdir(path):
        os.remove(path+file)
    for file in os.listdir(pa):
        os.remove(pa+file)
    imageFile='C:/Users/Abhi/Desktop/cbirfinalproject/project/testimg/test (72).jpg'
    xsize , ysize = Image.open(imageFile).size
    im=Image.open(imageFile)
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
    result=redhist+greenhist+bluehist
    compare(result)
def compare(r):
    global path
    global ext
    db = mysql.connector.connect(user='root', password='abhi',
                              host='localhost',
                              database='cbir')
    sql = 'SELECT colhist,id FROM imgdata;'
    key1=[]
    key2=[]
    cursor=db.cursor()
    cursor.execute(sql)
    data=cursor.fetchall()
    colid={}
    retrieved={}
    for item in data:
        colid[item[1]]=item[0]
    for key in colid.keys():
        r1=[]
        r1=r
        r2=[]
        st=str(colid[key])
        r2=st.split(':')
        r3=[]
        for i in r2:
            r3.append(int(i))
        dist=0
        for i in range(768):
            dist=dist+abs(r1[i]-r3[i])
        retrieved[dist]=key
    
    for g in range(30):
        saveImage(retrieved[sorted(retrieved)[g]],g)
    print "retrieved!!!"
def saveImage(x,g):
    global pa
    global path
    global ext
    db = mysql.connector.connect(user='root', password='abhi',
                              host='localhost',
                              database='cbir')
    
    sql1='select images from imgdata where id='+str(x)
    cursor=db.cursor()
    cursor.execute(sql1)
    data1=cursor.fetchall()
    file_like=cStringIO.StringIO(data1[0][0])
    img=PIL.Image.open(file_like)
    img.save(path+str(x)+ext)
    img.save(pa+str(g)+ext)    
if __name__ == '__main__':
  main()
