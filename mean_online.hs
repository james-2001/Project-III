import System.Random


main = do
  g <- getStdGen
  print $ take 10 (randoms g :: [Double])

foldMean x = foldl (b -> a -> b) b (t a)

foldFn a b 