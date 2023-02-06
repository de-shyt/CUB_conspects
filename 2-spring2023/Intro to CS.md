# Introduction to Computer Science

*Author: Daria Shutina*



[TOC]



### Haskell cheat sheet

A function that takes a Number (Integer, Double, Rational) and returns a Number

```haskell
f :: Num a => a -> a
f x = x^2
```



#### Lists

```haskell
concat [[1..3],[4..7],[8..10]]
reverse [1..10]

take 5 [1..]  -- [1, 2, 3, 4, 5]
drop 5 [1..10]  -- [6, 7, 8, 9, 10]

elem 5 [1..10]  -- if `5` is in the list

[1..] !! 9  -- take the 9-th elem, `!!` operation is not safe


```



#### Strings

```haskell
head "foo"  -- 'f'
tail "foo"  -- "oo"
last "foo"  -- 'o'
init "foo"  -- "fo"
```



#### map, filter, zip, zipWith

```haskell
map (\x -> x * 2 + 1) [1..3] -- [3, 5, 7]
map ((+ 1) . (* 2)) [1..10]  -- [3, 5, 7]

filter even [1..4]  -- [1, 3]

zip [1..] "hi"  -- [ (1,'h'), (2,'i') ]
zipWith (\a b -> (show a) ++ [b]) [1..] "hi"  -- [ "1h", "2i" ]
```



#### foldl, foldr

```haskell
foldl (-) 0 [1..3]  -- ((0 - 1) - 2) - 3 = -6
foldr (-) 0 [1..3]  -- 1 - (2 - (3 - 0)) = 2
```



#### quickSort

```haskell
import Data.List

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort smaller ++ [x] ++ quickSort larger
    where
    	(smaller, larger) = partition (< x) xs
```



#### Datatypes

```haskell
data EmployeeInfo = Employee String Int Double [String] deriving (Show)
--       type                    data constructor(s)
--   constructor        consists of components or fields of type
	
p = Employee "Joe Sample" 22 186.3 []
```

```haskell
data Person = Person 
    { name :: String
    , age :: Int 
    }
    deriving (Show, Eq)
    
increaseAge :: Person -> Person 
increaseAge person = person { age = age person + 1 } 
```



#### Binary tree

```haskell
data Tree a = Empty
            | Leaf a
            | Branch a (Tree a) (Tree a)
            deriving (Eq, Show)

toList :: Tree a -> [a]
toList Empty = []
toList (Leaf x) = [x]
toList (Branch x l r) = toList l ++ [x] ++ toList r

map :: (a -> b) -> Tree a -> Tree b
map f Empty = Empty
map f (Leaf x) = Leaf (f x)
map f (Branch x l r) = Branch (f x) (map f l) (map f r)
```

