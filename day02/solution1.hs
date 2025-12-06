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
isInvalidId n | length n_str `mod` 2 /= 0 = False
              | otherwise          = first_half == second_half
              where first_half  = take half_len n_str
                    second_half = drop half_len n_str
                    half_len    = length n_str `div` 2
                    n_str       = show n

splitBy :: String -> String -> [String]
splitBy sep str = map T.unpack $ T.splitOn (T.pack sep) (T.pack str)

trim :: String -> String
trim = T.unpack . T.strip . T.pack
