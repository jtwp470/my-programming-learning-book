{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Monoid  ((<>))
import System.IO (isEOF)
import qualified Data.Text    as T
import qualified Data.Text.IO as T

wordreverse2 :: T.Text -> T.Text
wordreverse2 xs
  | T.length xs < 2 = xs
  | otherwise = hajime <> manaka <> owari
    where
      hajime = T.take 1 xs
      manaka = T.reverse $ T.drop 1 $ T.take (T.length xs - 1) xs
      owari  = T.drop (T.length xs - 1) xs

main :: IO ()
main = do
  str <- T.getLine
  -- T.putStrLn str
  T.putStrLn $ T.unwords $ map wordreverse2 $ T.words str
  f <- isEOF
  if f then return() else main
