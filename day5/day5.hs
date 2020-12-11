
bisection :: [Char] -> Double
bisection s = fst (foldl (\(lower, upper) e -> if e =='F' then 
						(lower, (fromIntegral ((ceiling (fromIntegral (upper / 2)))))) 
					       else 
						((fromIntegral (ceiling (fromIntegral ( upper / 2)))), upper)) (0, 127) s)

{-- main :: IO ()
main = do
	input <- readFile "input.txt"--}
