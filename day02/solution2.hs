import qualified Data.Text as T

-- Solution
-- Check each number in ID ranges is invalid in a brute-force manner.

main = interact $ (++ "\n") . ans
     where ans = show . sum . map (sum . getInvalidIdsFromIdRange . parseIdRangeString) . splitBy "," . trim

getInvalidIdsFromIdRange :: [Int] -> [Int]
getInvalidIdsFromIdRange = filter isInvalidId

parseIdRangeString :: String -> [Int]
parseIdRangeString str = [lower..upper]
                       where lower  = read (parsed !! 0) :: Int
                             upper  = read (parsed !! 1) :: Int
                             parsed = splitBy "-" str

isInvalidId :: Int -> Bool
isInvalidId n = or $ map isFirstPartRepeatable [1..half_length]
              where isFirstPartRepeatable m = isRepeatable (take m n_str) n_str
                    half_length             = length n_str `div` 2
                    n_str                   = show n

isRepeatable :: String -> String -> Bool
isRepeatable pattern target | target_len `mod` pattern_len /= 0 = False
                            | otherwise                         = repeated == target
                            where repeated    = concat $ replicate t pattern
                                  t           = target_len `div` pattern_len
                                  pattern_len = length $ pattern
                                  target_len  = length $ target

splitBy :: String -> String -> [String]
splitBy sep str = map T.unpack $ T.splitOn (T.pack sep) (T.pack str)

trim :: String -> String
trim = T.unpack . T.strip . T.pack
