import mysql.connector
import sys
from PIL import Image
import cStringIO
import PIL.Image

def main():
    path="C:/Users/Abhi/Desktop/cbir-p/project/images"
    data=1
    a=[]

    for i in range(1000):
        a.append(data)
        data=data+1    
    for k in a:
        b=''
        imageFile =path+'/a ('+str(k)+').jpg' 
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
        result=[]
        result=redhist+greenhist+bluehist
        for r in result:
            b=':'.join(str(r) for r in result)
        insert(imageFile,b,k)
    print "inserted successfully"
def insert(imgf,st,j):
    db = mysql.connector.connect(user='root', password='abhi',
                              host='localhost',
                              database='cbir')
    blob_value = open(imgf, 'rb').read()
    sql = 'INSERT INTO imgdata(images,colhist,id) VALUES(%s,%s,%s)'
    args = (blob_value,st,j)
    cursor=db.cursor()
    cursor.execute(sql,args)
    db.commit()
    db.close()

if __name__ == '__main__':
  main()




