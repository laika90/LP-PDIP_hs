module Constants
    ( n, m, a, b, c, e, c1, c2,
      identity_nn,
      ones,
      zero_mat_mn,
      zero_mat_nn,
      zero_mat_mm,
      left_mat_top,
      left_mat_middle) where

import Numeric.LinearAlgebra

n :: Int -- the number of variables
n = 5

m :: Int -- the number of constraints
m = 2

a :: Matrix Double
a = (m >< n) [ 1,  3, -3, 1, 0,
               1, -1,  1, 0, 1 ]

b :: Vector Double
b = vector [3, 1]

c :: Vector Double
c = vector [-2, -1, 1, 0, 0]

e :: Double
e = 0.0005

c1 :: Double
c1 = 0.5

c2 :: Double 
c2 = 0.5

identity_nn :: Matrix Double
identity_nn = ident n

ones :: Vector Double
ones = konst 1 n

zero_mat_mn :: Matrix Double
zero_mat_mn = (m >< n) [1..] * 0

zero_mat_nn :: Matrix Double
zero_mat_nn = (n >< n) [1..] * 0

zero_mat_mm :: Matrix Double
zero_mat_mm = (m >< m) [1..] * 0 

left_mat_top :: Matrix Double
left_mat_top = a ||| zero_mat_mm ||| zero_mat_mn

left_mat_middle ::Matrix Double
left_mat_middle = zero_mat_nn ||| tr a ||| identity_nn



