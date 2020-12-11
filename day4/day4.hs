-- https://github.com/byorgey/split.git
-- se mi je zdela uporabna funkcija, pa sem sprobal kako gre namescanje paketov pri hasklu
-- bolj kopmlicirano kot C, ne tako preprosto kot 'pip install' :)
import Data.List.Split

checkValidity :: [String] -> Bool
checkValidity s = (elem "byr" s) && (elem "iyr" s) && (elem "eyr" s) && (elem "hgt" s) && (elem "hcl" s) && (elem "ecl" s) && (elem "pid" s)

countValid :: [String] -> Int
countValid s = foldl (\ acc e -> if (checkValidity (splitProperly (words e))) then acc + 1 else acc) 0 s

splitProperly :: [String] -> [String]
splitProperly s = foldl (\ acc e -> (splitOn ":" e) ++ acc) [] s

readUntilEmpty :: [String] -> [String]
readUntilEmpty s = fst( foldl(\ (acc, current) e -> if e /= "" then (acc, current ++ e ++ " ") else ( current : acc, "" )) ([], "") s )


main :: IO ()
main = do
	file <- (readFile "input.txt")
	-- da prebere tudi zadnjo vrstico
	let modifiedFile = file ++ "\n"
	let parsed = readUntilEmpty (lines modifiedFile)
	let count = countValid parsed
	putStrLn (show count)
