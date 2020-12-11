import Data.List

parse :: [String] -> [[String]]
parse s = fst (foldl (\(res, acc) e -> if e == "" then (acc : res, []) else (res, e:acc) ) ([], []) s)

unionAll :: [String] -> Int
unionAll s = length (foldl (\ acc e -> union acc e) "" s)

sumOfCounts :: [[String]] -> Int
sumOfCounts s = foldl (\ acc e -> acc + (unionAll e)) 0 s

main :: IO ()
main = do
	input <- readFile "input.txt"
	let modified = input ++ "\n"
	let res = sumOfCounts (parse (lines modified))
	putStrLn (show res)
