import Data.List.Split
import Data.Map (Map, insert, member, empty)

parseFile :: [String] -> [(String, Int)]
parseFile s = foldl (\ acc e -> acc ++ [(head (splitOn " " e), parseNum ((splitOn " " e) !! 1))] ) [] s

parseNum :: String -> Int
parseNum "" = 0
parseNum s = if head s == '-' then
                read s :: Int
             else
                 read (tail s) :: Int

run :: Map Int Int -> [(String, Int)] -> Int -> Int -> Int
run _ [] _ acc = acc
run map l ix acc = if Data.Map.member ix map then
                        acc
                    else 
                        do
                            let updatedMap = Data.Map.insert ix acc map
                            let execRes = executeCommand (l !! ix) acc ix
                            let newIx = snd execRes
                            let newAcc =  fst execRes
                            run updatedMap l newIx newAcc

executeCommand :: (String, Int) -> Int -> Int -> (Int, Int)
executeCommand (com, val) acc ix
        | com == "jmp" = (acc, ix + val)
        | com == "acc" = (acc + val, ix + 1)
        | otherwise = (acc, ix + 1)


main :: IO ()
main = do   
          file <- readFile "input.txt"
          print (show (run Data.Map.empty (parseFile (lines file)) 0 0))

