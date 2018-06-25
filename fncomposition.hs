-- λ Function Composition --

-- In Mathematics, fn composition is defined like this:
-- (f ∘ g)(x) => f((g(x))) meaning that compositing two fns produces
-- a new fn that when called with a parameter, such as x, is the equivalent of
-- calling g with x, then calling f with that result

-- Pretty much same thing in Haskell, fn composition is done with the '.' function
-- which is defined as such:

-- (.) :: (b->c) -> (a->b) -> a -> c        takes in b->c, and secondly a->b since this result is passed to the first, then a for input to the second, and outputs c
-- f . g = \x -> f (g x)

negateTimesThree = negate . (*3) -- Returns a NEW fn that takes a number, multiplies by three, then negates it

-- Fn composition can often be used instead of lambdas to create fns on the spot to pass to other fns
-- ex: Take a list of number, negate them all
negatedList' = map (\x -> negate (abs x)) [5,-3,-6,7,-3,2,-19,-24]
-- With a fn composition though, it can be written as:
negatedList = map (negate . abs) [5,-3,-6,7,-3,2,-19,-24]

-- fn composition is right-associative, so many fns can be composed at a time
-- f (g (z x)) == (f . g . z) x
-- therefor;

nsumtail' = map (\xs -> negate (sum (tail xs))) [[1..5],[3..6],[1..7]]  
nsumtail  = map (negate . sum . tail) [[1..5],[3..6],[1..7]] -- these are equivalent!



-- λ Function Composition & Functions that take several parameters--

-- Usually, we have to partially apply them so that each function takes just one parameter
sumrepmax' =  sum (replicate 5 (max 6.7 8.9)) -- can be written as;
sumrepmax  = (sum . replicate 5 . max 6.7) 8.9 -- or..
sumrepmax2 =  sum . replicate 5 . max 6.7 $ 8.9

-- Explanation;
-- "  a function that takes what max 6.7 takes and applies replicate 5 to it is created. Then, a function that takes the result of 
-- that and does a sum of it is created. Finally, that function is called with 8.9. But normally, you just read that as: apply 8.9 to 
-- max 6.7, then apply replicate 5 to that and then apply sum to that."

-- "If you want to rewrite an expression with a lot of parentheses by using function composition, you can start by putting the last
--  parameter of the innermost function after a $ and then just composing all the other function calls, writing them without their 
-- last parameter and putting dots between them. "

-- other example
repzip' = replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8]))) -- OR
repzip  = replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]



-- λ "Point free style" --
-- Also called 'pointless style'

-- sum' :: (Num a) => [a] -> a
-- sum' xs = foldl (+) 0 xs
-- the xs is on both right sides. Because of currying we can omit the xs on both sides
-- because calling fold (+) 0 creates a function that takes a list. Writing it as:
-- sum' = foldl (+) 0 ; is called writing it in point free style

--ex:
ceiltan' x = ceiling (negate (tan (cos (max 50 x))))
-- "We can't just get rid of the x on both right right sides. The x in the function body has parentheses after it. cos (max 50) wouldn't make sense. 
-- You can't get the cosine of a function. What we can do is express fn as a composition of functions."
ceiltan  x = ceiling . negate . tan . cos . max 50

-- Notes on long compositions;
-- "Many times, writing a function in point free style can be less readable if a fn is too complex. Making long chains of fn composition
-- is discouraged. The prefered style is to use let bindings to give labels to intermediary results or split the problem into sub problems
-- then put it together so that a function makes sense to someone reading it"

oddSquareSum'' :: Integer
oddSquareSum'' = sum (takeWhile (<10000) (filter odd map (^2) [1..])))
-- w/ fn composition:
oddSquareSum'  :: Integer
oddSquareSum'  :: sum . takeWhile (<10000) . filter . odd . map (^2) $ [1..]
-- however, to make it readable:
oddSquareSum   :: Integer
oddSquareSum =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in sum belowLimit
-- More readable^
