--
-- EPITECH PROJECT, 2021
-- pushswap checker haskell
-- File description:
-- pushswapchecker
--

import System.Environment
import System.Exit
import Text.Read
import Control.Monad


-- get args

getAction :: String -> [String]
getAction "" = []
getAction xs = words xs

listInt :: [String] -> Maybe [Int]
listInt [] = Just []
listInt xs = sequence (map readMaybe xs)


-- action functions

pushA :: ([Int], [Int]) -> ([Int], [Int])
pushA (xs, [])      = (xs, [])
pushA (xs, y:ys)    = (y:xs, ys)

pushB :: ([Int], [Int]) -> ([Int], [Int])
pushB ([],   ys) = ([], ys)
pushB (x:xs, ys) = (xs, x:ys)

swap :: [Int] -> [Int]
swap []         = []
swap (x:[])     = [x]
swap (x:y:xs)   = y:x:xs

rotate :: [Int] -> [Int]
rotate []       = []
rotate (x:xs)   = reverse $ x:reverse xs

rrotate :: [Int] -> [Int]
rrotate [] = []
rrotate xs = last xs : init xs


-- display

display :: Bool -> IO ()
display True  = putStrLn "OK" >> exitWith ExitSuccess
display False = putStrLn "KO" >> exitWith (ExitFailure 84)


-- main

temp :: [String] -> IO ()
temp str = getLine >>= display . checker . execAction (listInt str) . getAction

main :: IO ()
main = getArgs >>= temp


-- check sorting

isSorted :: [Int] -> Bool
isSorted [x]        = True
isSorted (x:y:ys)
    | x <= y        = isSorted (y:ys)
    | otherwise     = False

checker :: Maybe ([Int], [Int]) -> Bool
checker Nothing = False
checker (Just (xs, []))
    | isSorted xs   = True
    | otherwise     = False
checker _       = False


-- Execute actions


execAction :: Maybe [Int] -> [String] -> Maybe ([Int], [Int])
execAction Nothing _    = Nothing
execAction (Just [])   _       = Just ([], [])
execAction (Just xs)   []      = Just (xs, [])
execAction (Just xs)   actions = foldM doActions (xs, []) actions

doActions :: ([Int], [Int]) -> String -> Maybe ([Int], [Int])
doActions (listA, listB) "sa"     = Just ((swap listA, listB))
doActions (listA, listB) "sb"     = Just ((listA, swap listB))
doActions (listA, listB) "sc"     = Just ((swap listA, swap listB))
doActions (listA, listB) "pa"     = Just (pushA (listA, listB))
doActions (listA, listB) "pb"     = Just (pushB (listA, listB))
doActions (listA, listB) "ra"     = Just ((rotate listA, listB))
doActions (listA, listB) "rb"     = Just ((listA, rotate listB))
doActions (listA, listB) "rr"     = Just ((rotate listA, rotate listB))
doActions (listA, listB) "rra"    = Just ((rrotate listA, listB))
doActions (listA, listB) "rrb"    = Just ((listA, rrotate listB))
doActions (listA, listB) "rrr"    = Just ((rrotate listA, rrotate listB))
doActions (listA, listB) _        = Nothing