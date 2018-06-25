-- λ Scans --
-- scanl and scanr are like foldl and foldr except they return all intermediate accumulator states in the form of a list
-- scanl1 and scanr1 are analogous to foldl1 and foldr1

addAccums  = scanl (+) 0 [3,4,1,2,3]
-- > [0, 3, 7, 8, 10, 13]
addAccums' = scanr (+) 0 [3,4,1,2,3]
-- > [13, 10, 9, 7, 3, 0]
-- Note: using scanl, the final result is the last element of the list
-- while scanr places the result in the head

-- Find num of elements it takes for the sum of roots of all natural numbers to exceed 1000
sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1
--         ^get num results                         ^get sqrts from 1 to infinity
--                  ^while our results <1000 ^scanl1 returns a list of intermediate accums

-- λ Function applications with $ --

-- A normal fn application (i.e. putting a space between two things) has a high precedence, the $ fn
-- has the lowest precedence. fn application with a space is left associative so 
-- f a b c => same as (((f a) b) c) while fn application w/ $ is right associative

-- Most of the time, it helps us avoid writing many parentheses e.g.
-- sum (map sqrt [1..130]) => sum $ map sqrt [1..130]
-- When a $ is encountered, the expression on its right is applied as the parameter
-- to the fn on its left
-- sqrt 3 + 4 + 9 => 9 + 4 + (sqrt 3), if we want sqrt of 3+4+9 we could write
-- sqrt (3+4+9) or simply sqrt $ 3+4+9
-- sum(filter (>10) (map (*2) [2..10])) .. f(g(z(x))) == f $ g $ z x
-- therefor we can write 
sumSqGtTen = sum $ filter (> 10) $ map (*2) [2..10]

-- Also, $ means that fn application can be treated just like any other fns
-- We can for example map fn application over a list of functions..
fnls = map ($ 3) [(4+), (10*), (^2), sqrt]
-- [4+3, 10*3, 3^2, sqrt 3]