import qualified ParserTest (test)
import qualified TypeCheckTest (test)
import qualified EvalTest (test)

main = do
    putStrLn $ "Running ParserTest"
    ParserTest.test
    putStrLn $ "Running TypeCheckTest"
    TypeCheckTest.test
    putStrLn $ "Running EvalTest"
    EvalTest.test