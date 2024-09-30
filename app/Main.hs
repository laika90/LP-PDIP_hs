module Main (main) where

import Lib
import Constants
import PrimalDualInteriorPoints
import Numeric.LinearAlgebra

x0 = vector [1,1,1,1,1]
y0 = vector [1,1]
s0 = vector [1,1,1,1,1]
nu = 5


main :: IO ()
main = do
    print "hello world"