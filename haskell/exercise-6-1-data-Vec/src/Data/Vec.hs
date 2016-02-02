{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Data.Vec where

data Vec a = Vec a a a deriving (Show)

instance Num a => Num (Vec a) where
  fromInteger n = let nl = fromInteger n in Vec nl nl nl
  (Vec ax ay az) + (Vec bx by bz) = Vec (ax + bx) (ay + by) (az + bz)

(・) :: Num a => Vec a -> Vec a -> a
(Vec ax ay az) ・ (Vec bx by bz) = ax * bx + ay * by + az * bz

(×) :: Num a => Vec a -> Vec a -> Vec a
(Vec ax ay az) × (Vec bx by bz) = Vec (ay * bz - az * by) (az * bx - ax * bz) (ax * by - ay * bx)
