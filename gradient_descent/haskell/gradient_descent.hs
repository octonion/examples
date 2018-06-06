import Data.List

trainingSet = [ (1.0,10.0),(2.0,20.0),(3.0,30.0),(4.0,40.0) ]

hypothesis (d1,d2) x = d1 + (d2 * x)

squareDiff d (x,y) = diff * diff
    where diff = ( hypothesis d x ) - y

costFunc ts d = scaleFactor * sum squares
    where scaleFactor = 1.0 / (2 * genericLength ts)
          squares = map (squareDiff d) ts

diff d (x,y) = (hypothesis d x) - y 

descendTheta thetaFunc deltaFunc ts lr deltas = 
    deltaFunc deltas - (scaleFactor * sum scaledDiffs)
    where scaleFactor = lr / genericLength ts
          diffs = map (diff deltas) ts
          scaledDiffs = map (\(x,y) -> x * thetaFunc y) $ zip diffs ts

descendThetaZero = descendTheta (\_ -> 1) fst
descendThetaOne = descendTheta (fst) snd

singleDescend ts lr deltas = (thetaZero,thetaOne)
    where thetaZero = descendThetaZero ts lr deltas
          thetaOne = descendThetaOne ts lr deltas

descend func deltas i
    | i == 0 = deltas
    | otherwise = descend func ( func deltas ) ( i - 1 )

main = do
  let descentFunc = singleDescend trainingSet 0.1
  let deltas = descend descentFunc ( 100, 1 ) 100000
  print(deltas)
