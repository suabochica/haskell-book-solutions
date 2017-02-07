module Cipher.Vigenere where

import Data.Char
import Data.List

keyword  = "ALLY"
message  = "MEET AT DAWN"

-- key      = "ALLY AL LYAL"
-- encoded  = "MPPR AE OYWY"

vignere :: String -> String -> String
vignere message keyword = encoded
  where
    key = makeKey message keyword
    encoded = zipWith shiftByCharBase message key


makeKey :: String -> String -> String
makeKey message keyword = go message keyCycle
  where
    keyCycle = cycle keyword
    go [] _ = []
    go (x:xs) (y:ys)
      | x == ' '  = ' ' : go xs (y:ys)
      | otherwise =   y : go xs ys


shiftByCharBase :: Char -> Char -> Char
shiftByCharBase ' ' _ = ' '
shiftByCharBase char key =
    shift (toCharBase . ord $ key) char


-- caesar cipher from ch9

lowerBase = 97
upperBase = 65

toCharBase :: Int -> Int
toCharBase x = if x > 90
  then x - lowerBase
  else x - upperBase

applyOffset :: Int -> Int -> Int
applyOffset shift x =
  mod (x + shift) 26

shift n =
    chr
  . (+) upperBase
  . applyOffset n
  . toCharBase
  . ord
