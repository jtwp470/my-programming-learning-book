module Main where

wordreverse :: [Char] -> [Char]
wordreverse xs = do
  case length xs of
    0 -> xs
    1 -> xs
    2 -> xs
    _ -> head xs : [] ++ (reverse $ init $ tail xs) ++ (last xs : [])

main :: IO ()
main = do
  str <- getContents
  -- putStrLn $ unwords $ map wordreverse $ words str
  putStrLn $ unlines $ map unwords $ map (map wordreverse) $ map words $ lines str
