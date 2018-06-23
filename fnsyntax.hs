-- λ Haskell Syntactic Constructs: Pattern Matching --

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, Bucko!"
-- Patterns checked from top to bottom..
-- First fn body that matches pattern is used.
-- In this case, only 7 can be passed and match for the LUCKY message

sayNumber :: (Integral a) => a -> String
sayNumber 1 = "One!"
sayNumber 2 = "Two!"
sayNumber 3 = "Three!"  -- In this case, the function return the corresponding string
sayNumber 4 = "Four!"   -- Up to "Five!", then the last pattern matches any other number
sayNumber 5 = "Five!"
sayNumber x = "Not between 1 and 5!"

-- λ Factorial recursive w/ pattern --
factorial :: (Integral a) => a -> a
factorial 0 = 1 -- If value is 0, matches this
factorial n = n * factorial (n - 1) -- Otherwise matches this

-- Note: Pattern matching can fail if no patterns match, so always having a catch-all is good

-- λ Pattern matching on tuples --
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a) -- Takes in two pairs of type Numerical 'a', returns one of the same type
    -- We could do addVectors a b = (fst a + fst b, snd a + snd b) but instead:
addVectors (x1, y1) (x2, y2) = (x1+x2, y1+y2) -- Cleaner, pattern always matches since the type restricts it to this

first  ::   (a, b, c) -> a -- Implementing fs and snd but for triples
first       (x, _, _) = x
second ::   (a,b,c) -> b
second      (_, y, _) = y
third  ::   (a,b,c) -> c
third       (_, _, z) = z -- we use '_' to denote that we don't care about this value

xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
xso = [a+b | (a,b) <- xs] -- pattern matching in list comprehensions
-- If a pattern match fails, it moves to next element


-- λ Pattern matching on Lists --
head' :: [a] -> a -- Implementing 'head'
head' [] = error "Cannot call head on empty list"
head' (x:_) = x -- Return the first element, the rest is irrelevant
-- Note: When several variables are bound, they have to be surrounded in parantheses

heado = head' [4,3,2]


tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x -- [x] also valid - syntactic sugar
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y -- [x,y] also valid
tell (x:y:_) = " This list is long. This first two elements are: " ++ show x ++ " and " ++ show y
-- Note: can't rewrite (x:y:_) with square brackets because it matches any list of length 2 or more.


-- λ Implementing Length with PM and Recursion --
length' :: (Num b) => [a] -> b -- Takes in a list of any type 'a', returns a length in type 'Num'
length' [] = 0 -- If empty list, return 0
length' (_:xs) = 1 + length' xs -- Else, return 1 + value of rest of list
    -- We remove the head of the list and pass the rest recursively until we get our answer
    -- length' "ham":
    -- ln => 1 + ln "am" (1) + ln "m" (1) = 3

-- λ Implementing Sum --
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- λ "as patterns" --

-- Allows to break something up according to a pattern while keeping a reference to the whole
-- e.g. xs@(x:y:ys) matches the same thing as x:y:ys but we keep a reference to the whole 'xs'
firstLetter :: String -> String
firstLetter "" = "Empty string, d'oh!"
firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
    -- Useful to avoid repeating ourselves


-- λ Guards --

-- Similar to Switch statements, Guards are used to testing whether property of one or more values is True or False
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "Underweight!"
    | bmi <= 25.0 = "Normal!"
    | bmi <= 30.0 = "Fatty!"
    | otherwise   = "You're gonna die soon." -- otherwise is generally the last guard, otherwise = True and catches all (default in switch)

bmiTell' :: (RealFloat a) => a -> a -> String -- Implement with provided weight and height
bmiTell' weight height
    | bmi <= skinny = "Underweight!"
    | bmi <= normal = "Normal"
    | bmi <= fat = "Fatty!"
    | otherwise                 = "You're going to die soon."
    where bmi = weight / height ^ 2 --Instead of inlining the calculation 3times..
          skinny = 18.5
          normal = 25.0
          fat =    30.0  -- And other variables, too! Local to function
    -- Note: "Where bindings" are NOT shared across different patterns

max' :: (Ord a) => a -> a -> a -- Takes two orderable values and returns the biggest
max' a b
    | a > b     = a
    | otherwise = b
-- Guards can be inlined, but is not very readable
-- max' a b | a > b = a | otherwise = b  

compare' :: (Ord a) => a -> a -> Ordering
a `compare'` b -- could have just been compare a b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT -- Functions can be defined infix with backticks as well as

-- λ Pattern matching in where bindings --
initials :: String -> String -> String
initials fname lname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = fname
          (l:_) = lname

-- λ Defining functions in where bindings --
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs] -- get w and h from the xs list, pass them to the bmi fn
    where bmi weight height = weight / height ^ 2 -- bmi defined here
    -- Note: Let bindings can be nested

-- λ Let bindings --
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h -- names defined in 'let' are accessible in 'in' section
        topArea = pi * r^2
    in  sideArea + 2 * topArea
    -- Note: Unlike where bindings, let bindings are actually expressions and can be used almost anywhere

--ex:
fourtyTwo = 4 * (let a = 9 in a + 1) + 2 -- the expression evaluates to 9 + 1 = 10
lss = [let square x = x^2 in (square 1, square 2, square 3)] -- local scoped functions

-- To bind several variables inline,  seperate by semicolons:
blah = (let a = 1; b = 3 in a+b, let first ="Hey "; second ="Brotha" in first ++ second)

--Pattern matching with let bindings
-- (let (a,b,c) = (1,2,3) in a+b+c) * 100) => 600 | Here parentheses are used because of multiple values, it's not a tuple

--Let bindings in list comprehensions

calcBmis' :: (RealFloat a) => [(a, a)] -> [a]
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
-- names defined in a let inside list comprehension are visible to output function (left of |)
-- and all predicates/sections declared AFTER the binding


-- λ Case Expressions --

-- Similar to switches, again
-- case {expression} of {pattern} -> result
--                      {pattern} -> result
--                      {pattern} -> result
-- 
-- head' [] = error "blah"
-- head' (x:_) = x
-- is equivalent (and syntactic sugar for) the case expression:
-- case xs of []    -> error "blah"
--            (x:_) -> x

-- Case expressions are expressions and can be used anywhere
describeList:: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs  -> "a longer list."
-- also:
describe' :: [a] -> String
describe' xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
