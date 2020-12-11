countTrees :: [String] -> Int
countTrees (h:t) = fst (foldl (\ (acc, index) el -> if (el !! (mod index (length el))) == '#' then (acc + 1, index + 3) else (acc, index + 3 )) (0, 3) t)
