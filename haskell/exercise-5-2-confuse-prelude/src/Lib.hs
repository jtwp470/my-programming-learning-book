module Lib (
    (+)
  , (*)
  ) where


import qualified Prelude as P


(+) :: P.Num a => a -> a -> a
(+) = (P.*)

(*) :: P.Num a => a -> a -> a
(*) = (P.+)

infixl 6 *
infixl 7 +
