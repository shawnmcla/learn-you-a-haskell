-- λ Data.List --
import Data.List

-- Note: No need for qualified imports as the fns that 'clash' are actually just taken from Data.List by Prelude

-- λ intersperse: Takes an element and a list, puts that element in between each pair of elements in the list:
inter1 = intersperse '.' "YMCA" -- => "Y.M.C.A"
inter2 = intersperse 0 [1,2,3,4,5] -- => [1,0,2,0,3,0,4,0,5]

-- λ intercalate: takes a list of lists and a list, it then insserts
-- that list in between those lists and flattens the result. whew.
calate1 = intercalate " " ["hey", "there", "guys"] -- "hey there guys"
calate2 = intercalate [0,0,0] [[1,2,3],[4,5,6],[7,8,9]] -- [1,2,3,0,0,0,4,5,6,0,0,0,7,8,9]

-- λ Transpose: transposes a list of lists. If you look at a list of list as a 2D
-- matrix, the columns become the rows and vice versa.
matrx = [[1,2,3],[4,5,6],[7,8,9]]
matrx' = transpose matrx -- [[1,4,7],[2,5,8],[3,6,9]]
strtrans = transpose ["hey", "there", "guys"] -- ["htg", "ehu", "yey", "rs", "e"]

-- 3x^2 + 5x + 9,      10x^3 + 9,     8x^3 + 5x^2 + x - 1
polyn = map sum $ transpose [[0,3,5,9],[10,0,0,9],[8,5,1,-1]]
-- Added together: [18,8,6,17]
--      x^3     x^2     X       1
--              3       5       9
--      10      0       0       9
--      8       5       1       -1
-- +---------------------------------
--      18      8       6       17

-- λ foldl' and foldl1': stricter versions of their lazy incarnations
-- When using lazy folds on really big lists, we often get stack overflow errors
-- Accumulator value isn't updated as folding happens, it makes a promise that
-- it will compute its value when asked to actually show the result (thunk)
-- This happens to every intermediate accumulator and all the thunks overflow the stack
-- Strict folds aren't lazily evaluated.


-- λ concat: Flatten a list of lists --
concatted = concat [[1,2,3],[4,5,6],[7,8,9],[10,11,12]]
-- Note: Only removes one level of nesting, if a double nested list,
-- must be concatted twice

-- λ concatMap: Same as mapping then concatening
concatmap = concatMap (replicate 4) [1..3] -- [1,1,1,1,2,2,2,2,3,3,3,3]

-- λ and: Takes a list of boolean values and returns True if all values are True
andtrue = and $ map (>4) [5,6,7,8]
andfalse = and $ map (==4) [4,4,4,1]

-- λ or: Same as and, but only one value needs to be True
ortrue = or $ map (>4) [1,2,5,3]
orfalse = or $ map (==4) [1,1,1,1]

-- λ any/all: Takes a predicate and then checks if any/all elements of a list satisfy it
anytrue = any (==4) [1,2,3,4,5]
alltrue = all(>4) [5,6,8,9]
allfalse = all (`elem` ['A'..'Z']) "HEYGUYSwhatsup"
anytrue2 = any (`elem` ['A'..'Z']) "HEYGUYSwhatsup"

-- λ iterate: takes a fn and starting value. Applies the fn to the starting value,
-- then applies that fn to the result, again and again returning an infinite list
it10 = take 10 $ iterate(*2) 1 -- [1,2,4,8,16,32,64,128,256,512]
it3 = take 3 $ iterate (++ "haha") "haha" -- ["haha", "hahahaha", "hahahahahaha"]
