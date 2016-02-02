module Main where

import Control.Spoon (spoon)
import Control.DeepSeq (NFData)

predMay :: (Enum a, NFData a) => a -> Maybe a
predMay = spoon . pred

pred3 ::  (Enum a, NFData a) => a -> Maybe a
pred3 x = predMay x >>= (\y -> predMay y >>= (\z -> predMay z))

predN ::  (Enum a, NFData a) => Int -> a -> Maybe a
predN 0 x = Just x
predN 1 x = predMay x
predN n x = predMay x >>= (\y -> predN (n-1) y)

main :: IO ()
main = do
  putStrLn "hello world"
  print $ pred3 'd'
  print $ predN 3 'd'
  print $ predN 256 'a'
  print $ predN 32 'z'
  -- 確かめ
  print $ iterate (\x -> succ x) 'a' !! 32
