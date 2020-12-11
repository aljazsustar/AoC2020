getNthFromTouple :: (Int, Int, String) -> Int -> String
getNthFromTouple (n, _, _) 0 = (show  n)
getNthFromTouple (_, n, _) 1 = (show n)
getNthFromTouple (_, _, n) 2 = n

parseParams :: [String] -> (Int, Int, String)
parseParams [] = (0,0,"")
parseParams l = (fst (parse (l !! 0)),snd (parse (l !! 0)), [(l!!1)!!0])

parse :: String -> (Int, Int)
parse [] = (0,0)
parse l = (read (takeWhile (/= '-') l)::Int, -1 * (read (dropWhile (/= '-') l)::Int))

countOccurances :: String -> String -> Int
countOccurances [] _ = 0
countOccurances (h:t) ch = if h == (ch !! 0) then
				1 + countOccurances t ch
			   else
				countOccurances t ch

isValid :: String -> (Int, Int, String) -> Bool
isValid s params = if (countOccurances s (getNthFromTouple params 2)) <= (read  (getNthFromTouple params 1)::Int) && (countOccurances s (getNthFromTouple params 2)) >= (read (getNthFromTouple params 0)::Int) then
			True
		   else
			False

countValid :: [String] -> Int
countValid [] = 0
countValid (h:t) = if isValid ((words h)!!((length (words  h)) - 1)) (parseParams (words h)) then
			1 + (countValid t)
		   else
			(countValid t)
