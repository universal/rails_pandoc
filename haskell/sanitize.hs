-- compiled with: ghc 7.2 / sanitize-xss 0.31
import Data.Text.IO as D
import Text.HTML.SanitizeXSS
import System.IO as S
import Data.Text (Text)

main :: IO ()
main = do
       inpStr <- D.hGetContents S.stdin
       let result = sanitizeBalance inpStr
       D.hPutStr S.stdout result
       S.hClose S.stdin
       S.hClose S.stdout

-- compiled with: ghc 6.2 / 7.0 / older sanitize-xss package
-- import System.IO
-- import Text.HTML.SanitizeXSS
-- 
-- main :: IO ()
-- main = do 
--        inpStr <- hGetContents stdin
--        let result = sanitizeBalance inpStr
--        hPutStr stdout result
--        hClose stdin
--        hClose stdout