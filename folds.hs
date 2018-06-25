-- λ Folds --

-- Folds are similar to map, but they reduce the list to some single value
-- It takes a binary function, a starting value (accumulator) and a list to fold
-- the binary fn takes two parameters, and it is called with the accumulator and first(or last)
-- element and produces a new accumulator, and then the binary fn is called again with next elem
-- At the end, only the accumulator remains, which is the result (Basically reduce in JS)

-- λ Implementing sum with fold instead of recursion --
sum'' :: (Num a) => [a] -> a
sum'' xs = foldl (\acc x -> acc + x) 0 xs --foldl means fold left, from the left size
--                 ^                  ^ rest of the list
--           Binary fn               ^ starting value
sumls = sum'' [1,2,3,4,5]

-- Or, much more succint...
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0 -- The lambda (\acc x -> acc+x) is gnight

-- λ Implementing elem with left fold --
elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl(\acc x -> if x == y then True else acc) False ys


ls1 = [1,2,3,4,5]

-- λ Right Fold --
-- Same as left fold, but starts from the right side
-- Also, right fold's binary function has the current value as first parameter
-- and the accumulator as the second

-- Implementing map w/ foldr
map' :: (a->b) -> [a] -> [b]
map' f xs = foldr(\x acc -> f x : acc) [] xs -- accumulator is our new list, starting empty
-- every element goes through f and is added to the beginning of the list, from the right
-- with left fold: mapè f xs = foldl(\acc x -> acc ++ [f x]) [] xs
-- Issue is ++ function is more expensive than :
-- Therefor, usually use : when building new lists from a list

-- Folds can be used to implement any functions where you traverse a list once elem by elem
-- and return something based on it
-- foldl1 and foldr1 are the same, only they take the first (or last in foldr1) as the starting
-- accumulator value
sumf1 :: (Num a) => [a] -> a
sumf1 = foldl1 (+) -- sum can be implemented this way
-- However, foldl1 and foldr1 error when given an empty list, since it's trying to take the first(last) element

-- λ Implementing Various stlb fns using folds --
maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []
-- Also using flip;
reverse'' :: [a] -> [a]
reverse'' = foldl (flip(:)) [] -- since (\acc x -> x:acc) is essentially the reverse of (:)

product' :: (Num a) => [a] -> a
product' = foldl1 (*) -- or foldr1, naturally

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr(\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1(\x _ -> x)

last' :: [a] -> a
last' = foldl1(\_ x -> x)

-- Note: if binary fn is 'f', starting value is 'z' then
-- right fold over list [1,2,3] is essentially:
-- f 1(f 2(f 3 z))
-- left fold over same list with 'g' as fn:
--  g(g(g z 1) 2) 3)