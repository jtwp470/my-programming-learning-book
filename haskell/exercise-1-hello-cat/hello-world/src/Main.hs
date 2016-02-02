module Main where

main :: IO ()
main = do
  -- putStrLn "Hello world"
  interact $ const id "Hello world"
