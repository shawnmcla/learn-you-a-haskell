-- λ More on recursion --

-- Implementing maximum w/ recursion --
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Maximum of empty list."
maximum' [x] = x -- Duh.
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

-- "first set up an edge condition and say that the maximum of a singleton list is equal to 
-- the only element in it. Then we can say that the maximum of a longer list is the head if
-- the head is bigger than the maximum of the tail. If the maximum of the tail is bigger, well,
-- then it's the maximum of the tail. That's it! Now let's implement that in Haskell."
-- Note/Reminder: head is the first element of a list, tail is the rest

-- Alternatively, using max x y
maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "Maximum of empty list."
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum' xs) -- max takes two args and returns the biggest

-- Implementing replicate (Takes Int and some element and returns list Int long of the element)
-- ex: replicate 3 5 -> [5,5,5]
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x
    -- Note/Explanation: on n=0 (or less), return empty list
    -- Otherwise put x at the beginning of the list <replicate' (n-1) x>
    -- Note: Num is NOT a subclass of Ord, we must specify both Num and Ord constraints
    -- when doing addiction/subtraction and also comparison

-- Implementing take (take x [ls] returns the first x elements of the list)
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0    = [] -- if 'take'ing 0 or less, empty list (duh)
take' _ []      = [] -- taking anything from an empty list is also empty list
take' n (x:xs) = x : take' (n-1) xs
-- pattern here is n (Num, Ord) and whatever matches (x:xs, which is a list of 1 or more elems)

-- Implementing reverse
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x] -- append element(s) x to the end of reverse' xs (rest) recursively

-- Implementing repeat
-- Repeat takes one element and turns it into a repeating infinite list
repeat' :: a -> [a]
repeat' x = x:repeat' x -- repeat var = var:repeat var, infinite!

-- Implementing zip
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

-- Implementing elem
elem' :: (Eq a) => a -> [a] -> Bool -- a must implement Equality operations to be checked against!
elem' _ [] = False
elem' a (x:xs) 
    | a == x    = True
    | otherwise = a `elem'` xs



-- λ Quicksort! --

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted  = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted

-- "when trying to think of a recursive way to solve a problem, try to think of when a 
-- recursive solution doesn't apply and see if you can use that as an edge case, think
-- about identities and think about whether you'll break apart the parameters of the function
-- (for instance, lists are usually broken into a head and a tail via pattern matching) and on
-- which part you'll use the recursive call."

-- Practice

product' :: (Num a) => [a] -> a
product' [] = 1
product' (x:xs) = x * product' xs