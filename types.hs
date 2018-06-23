-- λ Types: Static & Infered --

-- In GHCI, use :t to explore type
-- > :t 'a'
-- => 'a' :: Char
-- > :t True
-- => True :: Bool
-- > :t "Hello"
-- => "Hello" :: [Char]     (List of Char)
-- > :t (True, 'a')
-- => (True, 'a') :: (Bool, Char)

-- Functions can be given type declarations:

-- removeNonUppercase :: [Char] -> [Char] -- Takes in a list of Chars, returns a list of Chars
removeNonUppercase :: String -> String -- String is synonymous to [Char] and clearer-ish
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- When there are more than one argument, we pass them along, return value is always the last one
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z



-- λ List of common Types --

-- Int:      Bound integer (32/64 bit, signed)
-- Integer:  Big, unbound integer (less efficient, huge numbers)
-- Float:    Real floating point, single precision 
-- Double:   Real floating point, double precision
-- Bool:     Boolean (True|False)
-- Char:     Character, denoted by single quotes 'a'

-- Example Function types:
-- :t head (Returns first element of a list) => head :: [a]     -> a
-- :t fst  (Returns first element of a pair) => fst  :: (a, b)  -> a



-- λ Typeclasses --
-- Typeclass ~= Interface. If a Type is part of a Typeclass, it supports/implements Typeclass behaviour
-- :t (==)
-- (==) :: (Eq a) => a -> a -> Bool
-- The Equality operator takes in two values of same Type and returns a Bool
-- The (Eq a) => part is a class constraint
-- In this case, the type 'a' must be a member of the 'Eq' class (Equality testing interface)
-- Note: All standard Haskell types except for IO and functions are part of the Eq Typeclass

-- "Ord" is for types that have an ordering (when comparing for order, GT, LT, EQ)
-- To be a member of "Ord", a class must first have membership in "Eq"

-- "Show" members can be presented as strings
-- ex: show 3 => "3", show True => "True"

-- "Read" takes a string and returns a type of member "Read"
readBool = read "True" || False
readDec = read "8.2" + 3.0
readInt = read "5" - 2
readls = read "[1,2,3,4]" ++ [3]
-- In these cases, the Type we are looking for is obvious given the other value we are working with
-- Doing 'read "4"' would be ambiguous because we don't know what Type we are trying to get
-- To work around, use explicit type annotations:
readIntAlone = read "5" :: Int 
readFloatAlone = read "5" :: Float
readPair = read "(3, 'a')" :: (Int, Char)
-- "Enum" members are sequentially ordered types, can be enumerated
-- Can be used in list ranges and have defined 'succ' and 'pred'
-- Types in this class: (), Bool, Char, Ordering, Int, Integer, Float and Double.
lsord = [LT .. GT] -- [LT, EQ, GT]
-- "Bounded" members have upper/lower bounds (e.g. Int, Char, Bool)
minInt = minBound :: Int
maxInt = maxBound :: Int
-- Tuples are part of "Bounded" if the components are also in it
maxBounds = maxBound :: (Bool, Int, Char) -- (True,9223372036854775807,'\1114111')
-- "Num" is the numeric typeclass, its members are able to act like a number
-- :t 20 => 20 :: (Num t) => t ... Whole numbers are sort of polymorphic, they can act like any type of "Num" typeclass
-- ex 20 :: Int, 20 :: Double, 20 :: Int all work
floatInt = 20 :: Float -- 20.0
-- :t (*) => (*) :: (Num a) => a -> a -> a ... The * operator takes all numbers of the SAME type
-- "Integral" typeclass for Int and Integer
-- "Floating" typeclass for Float and Double
-- fromIntegral takes an "Integral" class number and turns it into a 'general' "Number", to use when working w/ ints and floats
-- fromIntegral has multiple class constraints in type signature :: (Num b, Integral a) => a -> b ; valid
-- e.g. length [1,2,3] returns Int, so we cannot add or multiply with Floatings
-- Instead we can do fromIntegral (length [1,2,3]) + 2.3

