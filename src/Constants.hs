module Constants where

import Numeric.LinearAlgebra

--------------------------------------------------------------------------------------------------
-- LP 

n = 5                            :: Int -- the number of constants

m = 2                            :: Int -- the numbar of variables

a = (m >< n) [ 1,  3, -3, 1, 0,
               1, -1,  1, 0, 1 ] :: Matrix Double

b = vector [3, 1]                :: Vector Double

c = vector [-2, -1, 1, 0, 0]     :: Vector Double

--------------------------------------------------------------------------------------------------
-- some parameters 

e       = 0.0005 :: Double

gamma   = 0.5    :: Double

rho_max = 1e10   :: Double

beta    = 2.0    :: Double

eps     = 1e-5   :: Double

--------------------------------------------------------------------------------------------------
-- the matricies used in PDIP

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

--------------------------------------------------------------------------------------------------


