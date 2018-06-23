-- λ Functions --

doubleMe    x = x*2 -- simple function
doubleUs    x y = x*2 + y*2 -- multiple args
doubleUs'   x y = doubleMe x + doubleMe y -- composing a function
    -- Note: Order of function declarations in the file does not matter
    -- Infix notation: fn x y can be called as x `fn` y if it takes two parameters



-- λ If/else --

doubleSmall x = if x > 100 -- double if 100 or less
                    then x
                    else x*2

doubleSmallAddOne x = (if x > 100 then x else x*2) + 1 -- Alternative if syntax
    -- Note: else mandatory; if/else is an expression therefor always returns something
    -- Note 2: Functions may not begin with a capital letter



-- λ Lists --

numList = [2,7,9,13]
numList2 = numList ++ [1,2,3] -- "++" to combine lists
    -- Note: List elements must be of same type
    -- Note: "++" causes a walk through the whole left-side list, slow on long lists

phrase = 'H' : "ello world" -- ":" cons operator, puts something at the beginning of list
numbers = 0:[1,2,3,4]       -- Takes one element, not a list

-- Note: [1,2,3] is syntactic sugar for 1:2:3:[]

fifthElem = [0,1,2,3,4,5] !! 4 -- "!! <index>" returns element of list at index, starts at 0

l1 = [[1,1,1,1]]
l2 = [[2,2,2,2], [3,3,3,3]] -- List of lists
    -- Note: Lists of lists must all be same type, may be of different lengths 
l3 = l2 ++ l1 -- combine the two, adding [[1,1,1,1]] at the end of l2
l4 = l1 !! 0 : l2 -- Puts the sole list inside l1 at the beginning of l2

true1 = [1,2,3] > [1,4,3]
true2 = [1,2,3] > [1,2]
true3 = [1,2,3] == [1,2,3]
    -- Lists that contain elements that can be compared can be compared with < >= < >= ==
    -- Compares from first element, then second, etc.
    -- If two lists are equal but one is longer, that one is 'greater'



-- λ Lists: Basic Functions --

lshead  = head [1,2,3]  -- head: returns head (first element)        (1)
lstail  = tail [1,2,3]  -- tail: removes head and returns rest       ([2,3])
lslast = last  [1,2,3]  -- last: returns last element                (3)
lsinit  = init [1,2,3]  -- init: returns all but last element        ([1,2])

--  [   1,  2,  3,  4,  5,  6   ]
--    |head|             |last|
--          |------tail---------|
--  |--------init--------|
-- Note: These throw exceptions on empty lists!!

lslen = length  [1,2,3] -- length: returns legnth of list           (3)
lsnull = null   []      -- null: returns True if list is empty, False if not
lsrev = reverse [1,2,3] -- reverse: returns the list, reversed      ([3,2,1])

lstk = take 2   [1,2,3] -- take: takes x elements from beginning of list ([1,2])
lsdp = drop 2   [1,2,3] -- drop: removes x elements from beginning and returns rest ([3])

lsmx = maximum  [1,2,3] -- max: returns biggest element of list (must be comparable) (3)
lsmn = minimum  [1,2,3] -- min: returns smallest, like above                         (1)

lssm = sum      [1,2,3] -- sum: sums up a list of numbers                            (6)
lspr = product  [1,2,3] -- product: returns the product of all elements              (6)

lsel = elem 3   [1,2,3] -- elem: returns whether the first argument is in the list   (True)
lsel'= 3 `elem` [1,2,3] -- Same, infix notation!



-- λ Lists: Ranges --

oneToTen = [1..10] -- [1,2,3,4,5,6,7,8,9,10]
aToz     = ['a'..'z'] -- "abcdef[..]z" (strings are lists!)
ktoZ     = ['K'..'Z'] -- "KLMN[..]Z"

twentyByTwo = [2,4..20] -- specify a step! [2,4,6,8,10,12,14,16,18,20]
twentyByThree = [3,6..20] -- [3,6,9,12,15,18] 

twentyToOne = [20,19..1] -- [20,19,18,[..],1] May be in reverse too but must specify step
    -- Note: Using floating points in ranges is fucked

multsOf13 = [13,26..] -- Not specifying an upper limit results in an 'infinite list' (lazily evaluated)
thirtyNine = multsOf13 !! 2 -- return the third (index 2) element of the infinite list (39)

lsinf = cycle [1,2,3] -- cycle: "Cycles" a list into an infinite one, must be sliced to be displayed
    -- [1,2,3,1,2,3,1,2,3,1,2,3,..]
abcabca = take 7 (cycle "abc") -- take 7 first element of infinite cycled list
rept = repeat 6 -- repeat: Same as cycle but for one element, generates infinite list of that element
    -- [6,6,6,6,6,6,6,6,6,6,6,6,..]

repli = replicate 3 6 -- replicate x y: returns a list of y repeated x times 
    -- [6,6,6] (Simpler than take+repeat)



-- λ Lists: List Comprehensions --

double1to10 =   [x*2 | x <- [1..10]] -- pull x from list [1..10], apply *2 to every x
double1to10' =  [x*2 | x <- [1..10], x*2 >= 12] -- same, but we add a condition (only results >= 12)
fiftyto100d7i3 = [x | x <- [50..100], x `mod` 7 == 3]
    -- Every number from 50 to 100 where the mod of x is 3
    -- Note: Weeding out lists by predicates is called filtering

-- ex: Filter a list comprehension where every odd number >10 is "BANG!" and <10 "BOOM!"
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
    -- put the comprehension in a function to easily reuse
boomboombangbang = boomBangs [7..13]

mulpre = [x | x <- [10..20], x/=13, x/=15, x/=19] -- Multiple predicates can be used

mulls = [ x*y | x<-[1,2,3], y<-[10,100,1000]] -- multiple lists can be used!
    -- result will be computed for every combination of x and y, so results in a list of length 9
    -- [10,100,1000,20,200,2000,30,300,3000]

adjs = ["beautiful", "ugly", "tall"]
nouns = ["shrimp", "horse", "bamboo"]
combos = [adj ++ " " ++ noun | adj<-adjs, noun<-nouns]  -- Combining strings

length' xs = sum [1 | _ <- xs]
-- replace every element of the list with 1, essentially, and then sum all the 1's
-- equivalent to the length function

removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]
-- Since strings are lists, we can use comprehensions to produce/process them

poop = removeNonUppercase "abcPdOefOghP"

-- Remove all odd numbers from a nested list without flattening it
xxs = [[1,2,3,4,5],[10,11,12,13,14,15],[101,102,103]]
noOdds = [ [ x | x<- xs, even x] | xs <- xxs]
--1. xxs gets iterated through, each element (nested list) as xs
--2. each nested list (xs) is transformed into a list with its odd numbers stripped


-- λ Tuples --

tup1 = ("Shawn", "McLaughlin", 24) -- tuples take any number of elements and may be of different types
tupls = [(1,2), (3,4)] -- List of tuples must all be of the same shape

fst' = fst (1,2) -- fst: returns the first element of a PAIR (2-element tuple) (1)
snd' = snd (1,2) -- snd: returns the second element of a PAIR (2)

zipped = zip [1..10] ["one", "two", "three", "four"] -- zip creates PAIRs out of 2 lists. Stops at shortes list.
    -- NOTE: Also supports infinite lists

-- ex: Find which right triangle has all sides integers<10 and a perimeter of 24
triLess10 = [(a, b, c) | c<-[1..10], b<-[1..c], a<-[1..b], a^2+b^2==c^2, a+b+c==24] 
-- 1. generate all sides from 1 to 10 where c>=b>=a
-- 2. filter right triangles (asquare + bsquare = csquare)
-- 3. filter perimeter = 24