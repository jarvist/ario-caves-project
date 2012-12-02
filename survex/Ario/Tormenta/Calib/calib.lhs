This file contains various functions for converting between different
coordinate systems.

Firstly, some general vector operations.

>type Vector = (Float, Float)

Rotation, anticlockwise

>rotate :: Float -> Vector -> Vector
>rotate phi (x,y) = (x * cos phi - y * sin phi, x * sin phi + y * cos phi)

>add, sub :: Vector -> Vector -> Vector
>add (x1,y1) (x2,y2) = (x1+x2, y1+y2)
>sub (x1,y1) (x2,y2) = (x1-x2, y1-y2)

Some entrance coordinates in different systems, in order [(0,0) means no data]:
   2/7, Xitu, Cistra, Caracoles,
   1/6, 2/6, F2, F7(C),
   Verdelluenga, 

>old, gn, gps :: [Vector]
>old = [(1645, 198),  (1232, 1618),     (1946.06, 1126.03), (1840.20, 1330.29),
>       (-1097, 300), (-1176.22, 210.26), (-662.1,  -65.7), (-775.1, 116.2)]
>gn = [(3978.2, 8012.7), (3565.2, 9433.1), (0,0), (0,0),
>      (1236.6, 8115.3), (1166.8, 8020.5), (1671.5, 7749.6), (1558.5, 7931.5),
>      (2333.32, 7815.33)]
>gps = [(3871, 7807), (3459, 9232), (4169, 8763), (4093, 8970),
>       (0,0), (0,0), (0,0), (0,0), (2225, 7607)]

>compareV :: [Vector] -> [Vector] -> [Vector] 
>compareV = zipWith sub 

Convert between different formats
Following are exact (because old is derived from gn):

>old2gn, gn2old :: Vector -> Vector
>old2gn = add (2333.6, 7815.3)
>gn2old = sub (2333.6, 7815.3)

Following is best estimate

>gn2gps = sub (109.49, 211.49)
>gps2gn = add (109.49, 211.49)

>g x y = let (x', y') = gps2gn (x,y) in show x'++" "++show y'

Convert GPS to old coordinate system

Calibration angle; use 1998 figure

>theta :: Float
>theta = 0

theta = 2.65 * pi / 180.0 -- this should be right!

Top of Jultayu, GPS coordinates

>oldOrigin :: Vector
>oldOrigin = (0.0, 0.0) -- (2333.6, 7815.3)

>gps2old (x,y) = rotate (-theta) (sub (x,y) oldOrigin)

>old2gps (x,y) = add oldOrigin (rotate theta (x,y))

>xituTrans = sub (3459, 9232) (old2gps (1232, 1618))
>cistraTrans = sub (4169, 8762)   (old2gps (1946.06, 1126.03))
>pjultTrans = sub (3871, 7808) (old2gps (1645, 198))
>caracTrans = sub (4093, 8970) (old2gps (1840.20, 1330.29))

>allTrans = (xituTrans, cistraTrans, pjultTrans, caracTrans)