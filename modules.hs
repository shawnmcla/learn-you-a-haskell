-- λ Modules: Importing --

-- module import syntax: import <module name>, must be done before definitions, usually at top of file

import Data.List -- All functions from Data.List are now available in the global namespace
-- nub is a fn defined in Data.List that takes a list and removes duplicate elements
-- composing length and nub (length . nub) produces a fn that's the equivalent of \xs -> length (nub xs)


-- Note: Loading modules in GHCI
-- :m Data.List Data.Map

-- to import only some fns:
-- import Data.List (nub, sort)

-- to import all except some fns:
-- import Data.List hiding (nub)



-- λ Qualified Imports --

-- Data.Map has fns which share names as some Prelude fns (eg filter, null)
-- Qualified imports solve this:

-- import qualified Data.Map
-- Makes it so references Data.Map's filter fn, we must do Data.Map.filter
-- We can create an alias to make the name less tedious to write every time:

-- import qualified Data.Map as M

-- now we could do M.filter
