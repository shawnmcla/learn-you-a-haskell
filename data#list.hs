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

-- λ splitAt: takes a number and a list, returns a tuple of 2 lists split at that many elements
sp1 = splitAt 3 "heyguys" -- ("hey","guys")
sp2 = splitAt 100 "heyguys" -- ("heyguys", "")
sp3 = splitAt (-3) "heyguys" -- ("", "heyguys")
spflip = let (a, b) = splitAt 3 ("yahboo") in b ++ a

-- λ takeWhile: takes a predicate and a list, takes elements from the list until the predicate is false
whileGT3 = takeWhile(>3) [6,5,8,4,3,2,1,7,9] -- [6,5,8,4]
whileNotSpace = takeWhile (/=' ') "This is a sentence" -- "This"

-- Say we want the sum of all third powers under 10,000..
sumThirdPow = sum $ takeWhile (<10000) $ map (^3) [1..]

-- λ dropWhile: Drops elements and returns rest when predicate is false
drop1 = dropWhile (/=' ') "This is a sentence" -- " is a sentence"
drop2 = dropWhile (<3) [1,2,2,2,3,4,5,6,7,2,1] -- [3,4,5,6,7,2,1]

-- Stock values; we want to know when the stock value first exceeded 1,000$
-- (value, year, month, date)
stock = [(994.4,2008,9,1),(995.2,2008,9,2),(999.2,2008,9,3),(1001.4,2008,9,4),(998.3,2008,9,5)]
ans = head (dropWhile (\(val, y, m, d) -> val < 1000) stock)

-- λ span: like takeWhile but returns a pair of lists, the first is the same as takeWhile
-- the second is what was dropped

res = let (fw, rest) = span (/= ' ') "This is a sentence" in "First word: " ++ fw ++ ", rest:" ++ rest
-- "First word: This, the rest: is a sentence"

-- λ break: instead splits where the predicate is true
-- equivalent to span (not . p)
-- break (==4) [1,2,3,4,5,6,7] -> ([1,2,3],[4,5,6,7])

-- λ sort: Sorts a list whos element implement Ord
sorted1 = sort [8,3,1,3,2] -- [1,2,3,3,8]
sorted2 = sort "sort me bb" -- "  bbemorst"

-- λ group: takes a list and groups adjacent elements into sublists if they are equal
grouped1 = group [1,1,1,2,2,3,3,3,4,5,2,2] -- [[1,1,1],[2,2][3,3,3],[4],[5],[2,2]]
-- If we sort a list before grouping it, we can find out how many times each elem appears
sortgrp = map (\l@(x:xs) -> (x,length l)) . group . sort $ [1,1,1,1,2,2,2,2,3,3,2,2,2,5,5,6,7]
-- -> [(1,4),(2,7),(3,2),(5,2),(6,1),(7,1)]
-- Sort the list, group it, for every sublist take the first element(which is the same as all others)
-- and put it in a pair with the total length of the sublist

-- λ inits and tails: like init and tail, but recursively apply them until nothing is left
inits1 = inits "yay" -- ["", "y", "ya", "yay"]
tails1 = tails "yay" -- ["yay", "ay", "y", ""] 
-- let w = "w00t" in zip (inits w) (tails w)  
-- -> [("","w00t"),("w","00t"),("w0","0t"),("w00","t"),("w00t","")]  

-- Using fold to implement searching a list for a sublist
search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack = 
    let nlen = length needle
    in foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)
-- First we tails the list, then every tail is checked to see if it starts with needle
-- This is just like

-- λ isInfixOf:
is1 = "cat" `isInfixOf` "im a cat burglar" -- True
is2 = "Cat" `isInfixOf` "im a cat burglar" -- False

-- λ isPrefixOf, isSuffixOf: same thing, but at beginning and end of list respectively
is3 = "hey" `isPrefixOf` "hey there!" -- True
is4 = "hey" `isPrefixOf` "oh hey there!" -- False
is5 = "there!" `isSuffixOf` "oh hey there!" -- True
is6 = "there!" `isSuffixOf` "oh hey there" -- False

-- λ elem, notElem: checks if an elem is or isn't in a list
-- 'a' `elem` "damn" -> True
-- 'a' `notElem` "horse" -> True

-- λ partition: takes a list and a predicate, returns a pair of lists
-- first contains all elements that satisfy the predicate, second the ones that don't

part1 = partition (`elem` ['A'..'Z']) "SHAWNbananaMCLAUGHLINpudding"
-- ("SHAWNMCLAUGHLIN", "pudding")
part2 = partition (>3) [1,3,4,5,6,7,2,1,0]
-- ([4,5,6,7], [1,3, 2,1,0])
-- These differ from span/break because they terminate as soon as they encounter
-- an element that does (or doesn't) match the predicate, partition goes through the whole list

-- λ find: takes a list and predicate and returns the first element that satisfies p
-- That element is returned in a Maybe value; can either be "Just something" or "Nothing"
-- Just like a list can be empty list or a list with elements, a Maybe can be either
-- no elements or a single element. a list of integers is [Int], a maybe having an
-- integer is Maybe Int..?????? Sort of like a nullable int

find1 = find (>4) [1,2,3,4,5,6] -- Just 5
find2 = find (>9) [1,2,3,4,5,6] -- Nothing
-- :t find -> find :: (a -> Bool) -> [a] -> Maybe a

-- λ elemIndex: like elem, except returens the index where it is first encountered instead of a Bool
-- the index is a Maybe Int 
-- elemIndex :: (Eq a) => a -> [a] -> Maybe Int
ei1 = 4 `elemIndex` [1,2,3,4,5,6] -- Just 3
ei2 = 10 `elemIndex` [1,2,3,4,5,6] -- Nothing

-- λ elemIndices: like elemIndex but returns a list of indices of all occurences
-- list of Ints, because a list can be empty list, no need for a Maybe
ei3 = 4 `elemIndices` [1,4,2,3,4] -- [1,4]

-- λ findIndex: like find but maybe returns the index of the first elem that satisfies the predicate
-- λ findIndices: returns a list of indices of elements that satisfy the predicate
fi1 = findIndex (==5) [0,5,2,1] -- Just 5
fi2 = findIndex (==7) [0,5,2,1] -- Nothing
fi3 = findIndices (`elem` ['A'..'Z']) "Where Are The Capital Letters?" -- [0,6,10,14,22]

-- λ zip3, zipWith3, zip4, zipWith4..etc
-- Same as zip and zipWith but with 3, 4.. 7 lists!
zw3 = zipWith3 (\x y z -> x + y + z) [1,2,3] [4,5,2,2] [2,2,3] -- [7,9,8]
z4 = zip4 [1,2,3] [1,1,1] [0,0,0] [9,2,3] -- [(1,1,0,9), (2,1,0,2), (3,1,0,3)]
-- Just as w/ regular zipping, lists that are longer than the shortest are cut down

-- λ lines: a fn for dealing with files or input from somewhere, takes a string and
-- returns every line in a seperate list
lines1 = lines "first\nsecond\nthird" -- ["first", "second","third"]
-- λ unlines: reverse of lines, takes a list of strings and joins them with \n
unlines1 = unlines ["first", "second", "third"] -- "first\nsecond\nthird"

-- λ words/unwords: same as lines but splits words instead
w1 = words "hello there" -- ["hello", "there"]
w2 = words "Hello            my                  friend" -- ["hello", "my", "friend"]
uw1 = unwords ["yo", "what's", "up"] -- "yo what's up"

-- λ nub: takes a list and weeds out duplicates
nub1 = nub [1,1,2,2,4,4,3,3,5,2,2,2] -- [1,2,4,3,5]
nub2 = nub "hello jello potato" -- "helo jpta"

-- λ delete: takes an element and a list and deletes the fist occurence of that elem in the list
del1 = delete 'h'                               "hello there harold" -- "ello there harold"
del2 = delete 'h' . delete 'h' $                "hello there harold" -- "ello tere harold"
del3 = delete 'h' . delete 'h' . delete 'h' $   "hello there harold" -- "ello tere arold"

-- λ \\: list difference fn. Acts like a set difference; for every element in the right-hand
-- list, it removes a matching element from the left one
dif1 = [1..10] \\ [2,5,9] -- [1,3,4,6,7,8,10]
dif2 = "I'm a big potato" \\ "big" -- "I'm a   potato"
-- Doing [1..10] \\ [2,5,9] is like doing delete 2 . delete 5 . delete 9 $ [1..10]

-- λ union: acts like an union fn on two sets; 
-- Essentially goes over every element in second list and appends it to the first one
-- if it doesn't already have it. Duplicates are removed from second list!
un1 = "Hey buddy" `union` "buddy what's up" -- "Hey buddywhat'sp"
un2 = [1..7] `union` [5..10] -- [1,2,3,4,5,6,7,8,9,10]

-- λ intersect: Returns elements that are found in both lists
int1 = [1..7] `intersect` [5..10] -- [5,6,7]

-- λ insert: takes an element and a list of elements that can be sorted
-- and inserts it into the last position where it's still <= the next element
ins1 = insert 4 [3,5,1,2,8,2] -- [3,4,5,1,2,8,2]
ins2 = insert 4 [1,3,4,4,1] -- [1,3,4,4,4,1]