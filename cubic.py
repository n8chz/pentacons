#!/usr/bin/python

# playing with cubic functions of two variables

# import the MySQLdb and sys modules
import sys
#import array
#from scipy import *
import Image
import ImageDraw
import random
import math
# import os

width=1024
height=1024

def normalize(x):
    return math.atan(x)/math.pi+0.5

def denormalize(x):
    return math.tan((x-0.5)*math.pi)

def random_cauchy():
    return denormalize(random.random())

def makecubic(coeffs):
    return (lambda x,y: \
        coeffs[0] \
        +coeffs[1]*x \
        +coeffs[2]*y \
        +coeffs[3]*x*y \
        +coeffs[4]*x*x \
        +coeffs[5]*y*y \
        +coeffs[6]*x*x*y \
        +coeffs[7]*x*y*y \
        +coeffs[8]*x*x*x \
        +coeffs[9]*y*y*y)


def random_cubic():
    c=[]
    for i in range(10):
        c.append(random_cauchy())
    return makecubic(c)

canvas=Image.new("RGB", (width, height), (128,128,128))
draw=ImageDraw.Draw(canvas)

r=random_cubic()
g=random_cubic()
b=random_cubic()


for x in range(width):
    print "%3.2f%%" % (100.0*x/width)
    for y in range(height):
        x0=denormalize(1.0*x/width)
        y0=denormalize(1.0*y/height)
        rgb=(r(x0,y0),g(x0,y0),b(x0,y0))
        rgb=tuple(map(lambda x:int(256*normalize(x)),rgb))
        draw.point((x,y),rgb)
canvas.save("cubic.png", format="PNG")

sys.exit()

