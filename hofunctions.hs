-- λ Higher Order Functions --

-- : A function that takes a function as an argument or returns one as return value
-- Functions that take several parameters are actually curried
-- max 4 5 is equivalent to (max 4) 5. Putting a space between two things is a function application

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100 -- Here we use a partial application of compare and only pass 100
-- "The type declaration stays the same, because compare 100 returns a function. Compare has a type 
-- of (Ord a) => a -> (a -> Ordering) and calling it with 100 returns a (Num a, Ord a) => a -> Ordering.
-- The additional class constraint sneaks up there because 100 is also part of the Num typeclass."

divideByTen :: (Floating a) => a -> a
divideByTen = (/10) -- Infix functions are partially applied by using sections
-- Simply surround the function with parentheses and supply only parameters on one side
divideTenBy :: (Floating a) => a -> a
divideTenBy = (10/)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

applyTwice :: (a -> a) -> a -> a -- This fn takes a fn as a parameters
applyTwice f x = f (f x) -- Apply function f to x, twice.
-- Note: We use parantheses in the type declaration because the first argument is a function (a->a)

-- applyTwice (+3) 10 => 16
-- applyTwice (++ " HAHA") "POOP" => "POOP HAHA"\
--              ^- this is a partially applied function of ++, with the left side not yet defined
-- Passing it the string applies it to the left side of the operator/function

-- zipWith - Zip but instead of combining elements into pairs it applies a function to them
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y: zipWith' f xs  ys
-- Applies f to each pair of elements zipped from both lists
addEmUp x y = x+y
--zipWith' [1,2,3] [4,5,6] => [5,7,9]

-- Examples
--    ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]  
--    [6,8,7,9]  
--    ghci> zipWith' max [6,3,2,1] [7,3,1,5]  
--    [7,3,2,5]  
--    ghci> zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]  
--    ["foo fighters","bar hoppers","baz aldrin"]  
--    ghci> zipWith' (*) (replicate 5 2) [1..]  
--    [2,4,6,8,10]  
--    ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]  
--    [[3,4,6],[9,20,30],[10,12,12]]  

-- flip: takes a function and returns it with its first two arguments flipped
flip'' :: (a->b->c) -> (b->a->c) -- second pair of parantheses not necessary
flip'' f = g -- (a->b->c) -> b -> a -> c is equivalent ^
    where g x y = f y x -- if g x y = f y x, then f y x = g x y
-- Therefore, in a simpler manner
flip' :: (a->b->c) -> b -> a -> c
flip' f x y = f y x
-- ex: flip' (/) 5 2 => 2/5 => 0.4
divTwols = zipWith' (flip' div) [2,2..] [10,8..2]
-- => zipWith' div [10,8..2] [2,2..]

--     ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]  
--     [6,8,7,9]  
--     ghci> zipWith' max [6,3,2,1] [7,3,1,5]  
--     [7,3,2,5]  
--     ghci> zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]  
--     ["foo fighters","bar hoppers","baz aldrin"]  
--     ghci> zipWith' (*) (replicate 5 2) [1..]  
--     [2,4,6,8,10]  
--     ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]  
--     [[3,4,6],[9,20,30],[10,12,12]]  

-- λ Implementing Map --
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f(x:xs) = f x : map' f xs -- Same as in js and other languages

mapOnes = map' fst [(1,2), (1,3), (1,4)] -- [1,1,1]

-- λ Implementing Filter --
filter' :: (a->Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs) -- p is Predicate (a fn that returns a Bool when a x is applied to it)
    | p x       = x : filter p xs -- If p of x returns True, this Guard is used
    | otherwise = filter p xs -- Else (False), we skip that element

lessThreels = filter' (<3) [-1,0,2,3,4,5,6] -- [-1,0,2]
lessFivels = let isLessThan5 x = x<5 in filter' isLessThan5 [1,2,3,4,5,6,7,8,9,10] -- [1,2,3,4]

-- λ Implementing Quicksort with filter --
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
        let smallerSorted = quicksort (filter (<=x) xs)
            biggerSorted = quicksort (filter (>x) xs)
        in smallerSorted ++ [x] ++ biggerSorted

-- λ Problem: Find the largest number under 100,000 that's divisible by 3829
largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000,99999..]) 
    where p x = x `mod` 3829 == 0
    -- Note: we are using an infinite list, since we take only one element (the head)
    -- of the possible results, evaluation stops as soon as a suitable value is found #lazy

-- λ takeWhile --
-- Takes a predicate and a list, returning elements of a list from the beginning
-- while the predicate holds true

-- Sum of all odd squares that are smaller than 10,000
sumos = sum(takeWhile (<10000) (filter odd (map (^2) [1..])))
--     While the value is less than 10,000
--      map values of infinite list starting at 1++
--       from that list filter using the odd fn which results in a list of odd squares
--          sum the total

-- Alternatively, with list comprehensions:
sumos' = sum (takeWhile (<1000) [n^2 | n <- [1..], odd (n^2)])

-- λ Collatz sequences (if even, divide by two, if odd, multiply by 3 and add 1) --
-- Generate chain
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n = n:chain(n `div` 2)
    | odd n  = n:chain(n*3 +1)

-- For all starting numbers between 1 and 100, how many chains have a length > 15 --
numLongChains :: Int
numLongChains = length(filter isLong (map chain[1..100]))
    where isLong xs = length xs > 15
    -- Range list from 1 to 100, for each value map to the chain function, filter the list of chains
    -- with the isLong function, which is True when the length is greater than 15

-- Note/Reminder: Partially applied functions are real values that can be passed around to fns and
-- put into lists. Example: map (*) [0..] returns a list of partially applied multiplication
-- functions such as [(0*), (1*), (2*), ..]
-- (*) has type (Num a) => a -> a -> a ; it takes in 2 Num and returns 1 Num
-- a list of partially applied (*0) has type (Num a) => [a -> a] where the a->a elements are fns

-- λ Lambdas --
-- Similar to Python, Lambdas are expressions that start with the character '\' because it looks
-- nothing like λ
-- We write parameters, seperated by spaces, -> and the function body. Surround w/ parantheses
-- so the expression doesn't extend all the way to the right. They can be passed as a regular fn

-- numLongChains with lambda instead of a where binding:
numLongChains' :: Int
numLongChains' = length(filter (\xs -> length xs > 15) (map chain[1..100]))
-- We have replaced the isLong where binding with a lambda function

-- Note: People not acquainted with currying and partial application often use
-- lambdas when not necessary;
-- map (+3) [1,2,3,4,5]   and
-- map (\x -> x+3) [1,2,3,4,5] are equivalent and the former is more readable

-- Lambdas can take any number of arguments
-- You can pattern match in Lambdas, but not multiples
-- Failing pattern match results in a runtime error

-- addThree x y z = x + y + z
-- addThree = \x -> \y -> \z -> x + y + z
-- are equivalent due to fns being curried by default
-- Can be useful when implementing flip
flip2 :: (a->b->c) -> b -> a -> c
flip2 f = \x y -> f y x
-- makes it obvious that this fn produces a new fn most of the time
-- instead of writing f x y = f y x