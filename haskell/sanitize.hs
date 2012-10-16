-- This binary sanitizes html-fragments passed in to avoid
-- cross-site scripting (XSS) attacks.
--
-- The string to be sanitized is read from stdin and the result is written
-- to stdout.
module Main where

import Data.Text.IO          as D (hGetContents, hPutStr)
import Text.HTML.SanitizeXSS      (sanitizeBalance)
import System.IO             as S (hClose, stdin, stdout)

main :: IO ()
main = do
  -- sanitize
  D.hGetContents S.stdin >>= D.hPutStr S.stdout . sanitizeBalance
  -- clean up
  S.hClose S.stdin
  S.hClose S.stdout
