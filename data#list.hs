-- λ Data.List --
import Data.List

-- Note: No need for qualified imports as the fns that 'clash' are actually just taken from Data.List by Prelude

-- λ intersperse: Takes an element and a list, puts that element in between each pair of elements in the list:
inter1 = intersperse '.' "YMCA" -- => "Y.M.C.A"
inter2 = intersperse 0 [1,2,3,4,5] -- => [1,0,2,0,3,0,4,0,5]