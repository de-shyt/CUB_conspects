# Introduction to Computer Science

*Author: Daria Shutina*



[TOC]



## Haskell cheat sheet

A function that takes a Number (Integer, Double, Rational) and returns a Number

```haskell
f :: Num a => a -> a
f x = x^2
```



### Lists

```haskell
concat [[1..3],[4..7],[8..10]]
reverse [1..10]

take 5 [1..]  -- [1, 2, 3, 4, 5]
drop 5 [1..10]  -- [6, 7, 8, 9, 10]

elem 5 [1..10]  -- if `5` is in the list

[1..] !! 9  -- take the 9-th elem, `!!` operation is not safe


```



### Strings

```haskell
head "foo"  -- 'f'
tail "foo"  -- "oo"
last "foo"  -- 'o'
init "foo"  -- "fo"
```



### map, filter, zip, zipWith

```haskell
map (\x -> x * 2 + 1) [1..3] -- [3, 5, 7]
map ((+ 1) . (* 2)) [1..10]  -- [3, 5, 7]

filter even [1..4]  -- [1, 3]

zip [1..] "hi"  -- [ (1,'h'), (2,'i') ]
zipWith (\a b -> (show a) ++ [b]) [1..] "hi"  -- [ "1h", "2i" ]
```



### foldl, foldr

```haskell
foldl (-) 0 [1..3]  -- ((0 - 1) - 2) - 3 = -6
foldr (-) 0 [1..3]  -- 1 - (2 - (3 - 0)) = 2
```



### quickSort

```haskell
import Data.List

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort smaller ++ [x] ++ quickSort larger
    where
    	(smaller, larger) = partition (< x) xs
```



### Datatypes

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



### Binary tree

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

foldr :: (a -> b -> b) -> b -> Tree a -> b
foldr _ z Empty = z
foldr f z (Leaf x) = f x z
foldr f z (Branch x l r) = foldr f (f x (foldr f z r)) l

foldl :: (a -> b -> b) -> b -> Tree a -> b
foldl _ z Empty = z
foldl f z (Leaf x) = f x z
foldl f z (Branch x l r) = foldr f (f x (foldl f z l)) r
```



### Typeclasses

Typeclasses describe a set of types that have a common interface and behavior. A type belonging to a typeclass implements the functions and behavior defined by the typeclass. 

Let us look at the expression:

```haskell
(Eq a) => a -> a -> Bool 
```

Everything before the symbol `=>` is a *class constraint*. 





#### Usage of a constraint in a function declaration

We want to check whether the element is in the given list. We put a constraint on a type `a` -- it should be an instance of `Eq` typeclass. 

```haskell
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem y (x:xs) = y == x || elem y xs
```





#### Eq

```haskell
class Eq a where
	(==) :: a -> a -> Bool
	(==) a b = not (a /= b) -- default implementation
	(/=) :: a -> a -> Bool
	(/=) a b = not (a == b) -- default implementation
```

`a` is an instance of typeclass `Eq`. It can overload operators `==` and `/=` of use a default version. 





##### Creating an instance of Eq

```haskell
-- custom type
data Weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun

instance Eq Weekday where
	Mon == Mon = True
	Tue == Tue = True
	Wed == Wed = True
	Thu == Thu = True
	Fri == Fri = True
	Sat == Sat = True
	Sun == Sun = True
	_ == _ = False
```

```haskell
-- lists
-- we create an instance of a list and also put a constraint on a type `a`
instance Eq a => Eq [a] where
	[] == [] = True
	(x:xs) == (y:ys) = x == y && xs == ys
	_ == _ = False
```





#### Ord

It is an extension of `Eq`, so `Ord` is a subclass of `Eq`.

Default implementation:

```haskell
data Ordering = LT | EQ | GT

instance Eq Ordering where
    LT == LT = True
    EQ == EQ = True
    GT == GT = True
    _ == _ = False

class (Eq a) => Ord a where
    (<), (<=), (>=), (>) :: a -> a -> Bool
    compare :: a -> a -> Ordering
    max, min :: a -> a -> a
    
    compare x y | x == y = EQ 
                | x <= y = LT
                | otherwise = GT
                
    x <= y = compare x y /= GT 
    x < y = compare x y == LT 
    x >= y = compare x y /= LT
    x > y = compare x y == GT 
    
    max x y | x <= y = y
    		| otherwise = x
    
    min x y | x <= y = x 
   			| otherwise = y
```





#### Functor



















