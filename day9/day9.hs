import Data.List

splitPreamble :: [String] -> ([Int], [Int])
splitPreamble [] = ([], [])
splitPreamble s = splitAt 25 (map (\x -> read x :: Int) s) 

isSum :: Int -> Int -> [Int] -> Bool
isSum _  _ [] = False
isSum _ _ [_] = False
isSum _ 24 _ = False
isSum n i l = case find (\ el -> el + (l !! i) == n) (delete (l !! i) l) of

                Nothing -> isSum n (i + 1) l
                Just _ -> True

run :: ([Int], [Int]) -> Int
run ([], []) = 0
run (l, h2 : t2) 
                | isSum h2 0 l = run (tail l ++ [h2], t2)
                | not (isSum h2 0 l) = h2

main :: IO ()
main = do
        file <- readFile "input.txt"
        print (run (splitPreamble (lines file )))