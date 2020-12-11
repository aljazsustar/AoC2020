import Data.List

parseFile :: [String] -> [Int]
parseFile = map (\ el -> read el :: Int) 

res :: [Int] -> (Int, Int) -> Int -> Int
res [] (one, three) _ = one * (three + 1)
res l (one, three) lastUsed = do
                                let minLeft = minimum (filter (\x -> x - lastUsed == 1 || x - lastUsed == 3) l)
                                let jDiff = minLeft - lastUsed

                                if jDiff == 1 then
                                    res (delete minLeft l) (one + 1, three)  minLeft
                                else
                                    res (delete minLeft l) (one, three + 1)  minLeft

main :: IO ()
main = do
        
        file <- readFile "input.txt"
        print (res (parseFile (lines file)) (0,0) 0)




