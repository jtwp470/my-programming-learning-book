module Main where

import qualified Data.Map as M

-- guzaiがnabeに入っていたらその具材の個数を１減らす、
-- guzaiの個数がゼロになったらその項目をMapから消す、
-- ように、関数eatを追記してください。
eat :: String ->  M.Map String Int -> M.Map String Int
eat guzai nabe = do
  let num = M.lookup guzai nabe in
    case num of
      Just x ->
        if x <= 1 then M.delete guzai nabe
        else
          let f key n = if key == guzai then Just (n - 1) else Nothing in
          M.updateWithKey f guzai nabe
      _ -> nabe


party :: M.Map String Int -> IO ()
party nabe = do
  putStrLn $ "Nabe: " ++ show nabe
  order <- getLine
  let newNabe = eat order nabe
  -- 鍋が空かどうかを判定する
  if M.null nabe then putStrLn "The party is over!"
  else party newNabe

-- http://stackoverflow.com/questions/3067048/haskell-convert-list-to-list-of-tuples
stride _ [] = []
stride n (x:xs) = x : stride n (drop (n-1) xs)

toPairs xs = zip (stride 2 xs) (stride 2 (drop 1 xs))

readRecipe :: IO (M.Map String Int)
readRecipe = do
  content <- readFile "recipe.txt"
  -- content の内容を解釈して、おいしそうな鍋の中身を作ってください！
  let lst = words content in
    let ret = zip (stride 2 lst) (map read . stride 2 . drop 1 $ lst) :: [(String,Int)] in
    return $ M.fromList ret
  -- return $ M.fromList [("Kuuki",1)]

main :: IO ()
main = do
  initialNabe <- readRecipe
  party initialNabe
