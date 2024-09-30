module PrimalDualInteriorPoints
    (determineSearchDirection) where

import Prelude hiding ((<>))
import Numeric.LinearAlgebra
import Constants

--------------------------------------------------------------------------------------------------
  
type State        = Vector Double
type SubState     = Vector Double
type Direction    = Vector Double
type SubDirection = Vector Double

--------------------------------------------------------------------------------------------------

determineSearchDirection :: State -> Double -> Maybe (Direction)
determineSearchDirection state_k nu = maybe_direction -- state_k = vector [xk, yk ,sk]
    where 
        (xk, yk, sk) = splitState state_k

        rbk = a #> xk - b
        rck = (tr a) #> yk + sk - c

        xk_diag = diag xk
        sk_diag = diag sk

        -- left_mat_top
        -- left_mat_middle  are defined in Constants.hs
        left_mat_bottom = sk_diag ||| tr zero_mat_mn ||| xk_diag

        left_mat = left_mat_top === left_mat_middle === left_mat_bottom
        right_vec = - vjoin [rbk, rck, (xk_diag #> sk - ones * scalar(nu))]
    
        maybe_direction = fmap flatten $ linearSolve left_mat $ matrix 1 $ toList right_vec

splitState :: State -> (SubState, SubState, SubState)
splitState state_k = (xk, yk, sk)
  where
    xk = subVector 0 n state_k             
    yk = subVector n m state_k           
    sk = subVector (n+m) n state_k 

--------------------------------------------------------------------------------------------------

determineStep :: State -> Maybe (Direction) -> Double
determineStep state_k maybe_direction = 
    case maybe_direction of
        Nothing -> 0
        Just direction -> 
            let (xk, yk, _) = splitState state_k
                (dx, dy, _) = splitState direction
                alpha_x_max = calculateMaxAlphaX xk dx
                alpha_y_max = calculateMaxAlphaY yk dy
                alpha_max   = min alpha_x_max alpha_y_max
            in backtrack xk dx rho nu alpha_max

backtrack :: SubState -> SubDirection -> Double -> Double -> Double -> Double
backtrack xk dx rho nu alpha_max = backtrackHelper alpha_max
    where
        backtrackHelper alpha 
            | meritFunc (xk + (scalar alpha) * dx) rho nu <= meritFunc xk rho nu + c1 * (gradMeritFunc xk rho nu) <.> dx * alpha = alpha
            | otherwise = backtrackHelper (c2*alpha)
        c1 = 1e-4
        c2 = 0.5

calculateMaxAlphaX :: SubState -> SubDirection -> Double
calculateMaxAlphaX xk dx = 
    case calculateMaxAlpha xk dx of 
        Nothing -> 1
        Just alpha -> alpha

calculateMaxAlphaY :: SubState -> SubDirection -> Double
calculateMaxAlphaY yk dy = 
    case calculateMaxAlpha yk dy of
        Nothing -> 1
        Just alpha -> alpha

calculateMaxAlpha :: SubState -> SubDirection -> Double
calculateMaxAlpha wk dw 
    | all (==0) dw = Nothing
    | all (\(w, d) -> w + d <= e * w) (zip wk dw) = Nothing
    | otherwise = Just $ min 1 $ max 0 $ (e * wk - wk) / (sum dw)

meritFunc :: SubState -> Double -> Double -> Double 
meritFunc x rho nu = f x + rho * (norm_2 $ h x) + nu * (entropy x) 

gradMeritFunc :: SubState -> Double -> Double -> Vector Double
gradMeritFunc x rho nu = c + scalar rho * (tr a) #> (h x) / scalar (norm_2 $ h x) + scalar nu * (cmap (\xi -> -1/xi) x) 

f :: SubState -> Double
f x = c <.> x

h :: SubState -> Vector Double
h x = a #> x - b

entropy :: SubState -> Double
entropy x =  - sumElements $ cmap log x

--------------------------------------------------------------------------------------------------




