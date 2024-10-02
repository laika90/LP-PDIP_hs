module Main (main) where

import PrimalDualInteriorPoint
import Numeric.LinearAlgebra

main :: IO ()
main = print $ last_state
    where
        last_state = runSteps initial_state rho nu max_iteration

        x0            = [1,2,3,4,5]             :: [Double]
        y0            = [-1,-1]                 :: [Double]
        s0            = [1,1,1,1,1]             :: [Double]
        rho           = 10                      :: Double
        initial_state = vector $ x0 ++ y0 ++ s0 :: Vector Double
        nu            = dualGap initial_state
        max_iteration = 1000
