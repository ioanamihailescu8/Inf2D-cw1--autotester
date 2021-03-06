module Tests where

import ConnectFourWithTwist
import Inf2d1

type Matrix = [[Int]]

data GraphObj = GraphObj {
  label :: !String,
  adjMtx :: !Matrix,
  hrTable :: ![Int]
}

data TestSearch = TestSearch {
  description :: !String,
  graphObj :: !GraphObj,
  startBranch :: !Branch,
  endNode :: !Node,
  testDepth :: !Int,
  bfs :: !Branch,
  dfs :: !Branch,
  ass :: !Branch
}

data TestAlphaBeta = TestAlphaBeta {
  description_ab :: !String,
  inpGame_ab :: !Game,
  inpPlayer_ab :: !Role,
  outInt_ab :: !Int
}

data TestNext = TestNext {
  inpBranch_next :: !Branch,
  inpGraph_next :: !GraphObj,
  outBranches_next :: ![Branch]
}

data TestCheckArrival = TestCheckArrival {
  inpNode1_checkArrival :: !Node,
  inpNode2_checkArrival :: !Node,
  outBool_checkArrival :: !Bool
}

data TestExplored = TestExplored {
  inpNode_explored :: !Node,
  inpNodes_explored :: ![Node],
  outBool_explored :: !Bool
}

data TestCost = TestCost {
  inpGraph_cost :: !GraphObj,
  inpBranch_cost :: !Branch,
  outInt_cost :: !Int
}

data TestGetHR = TestGetHR {
  inpHRTable_getHR :: ![Int],
  inpNode_getHR :: !Node,
  outInt_getHR :: !Int
}

data TestEval = TestEval {
  inpGame_eval :: !Game,
  outInt_eval :: !Int
}


emptyGraph = GraphObj "Empty graph"
 [[]]
  []

simple = GraphObj "Simple graph"
 [[0, 1, 0],
  [0, 0, 1],
  [0, 0, 0]]
  [1, 1, 1]

simpleLoop = GraphObj "Simpe graph with a loop"
 [[0, 1, 0],
  [1, 0, 1],
  [0, 0, 0]]
  [1, 1, 1]

complexLoop0 = GraphObj "Simple graph with loops"
 [[0, 1, 0, 0],
  [0, 0, 1, 0],
  [1, 0, 0, 1],
  [0, 0, 0, 0]]
  [1, 1, 1, 1]

complexLoop1 = GraphObj "Simple graph with loops"
 [[0, 1, 1, 0, 0],
  [0, 0, 1, 0, 0],
  [0, 0, 0, 1, 0],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0]]
  [1, 1, 1, 1, 1]



biparte = GraphObj "Simple tree (small depth)"
 [[0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0]]
  [1, 1, 1, 1, 1]

simpleGraph = GraphObj "Graph 1"
 [[0, 1, 1, 0, 0],
  [0, 0, 0, 1, 0],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0]]
  [1, 1, 1, 1, 1]

bigGraph = GraphObj "Big graph"
 [[0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 1, 1, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0]]
  [1, 1, 1, 1, 1, 1, 1, 1]

hugeGraph = GraphObj "Huge graph"
 [[0, 3, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0],
  [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
  [5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 0]

auto0 = GraphObj "Autogenerated 1"
  [[0,0,0,1,1,0,1,0,1,0],[0,1,1,1,1,0,0,0,1,1],[1,0,0,1,0,1,0,0,0,0],[1,0,1,1,0,0,1,0,1,0],[0,0,0,0,0,1,0,0,1,0],[0,0,0,0,0,0,0,0,0,0],[1,0,1,0,1,1,0,0,0,0],[0,0,1,0,1,0,0,0,0,0],[0,1,1,0,0,0,1,0,0,0],[0,1,0,0,0,0,0,1,0,1]]
  [1,1,1,1,1,1,1,1,1,1]

testSimple = TestSearch "Search on simple graph" simple [0] 2 5 [0,1,2] [0,1,2] [0,1,2]
testSimpleMid = TestSearch "Search on simple graph starting from node 1" simple [1] 2 5 [1,2] [1,2] [1,2]
testSimplePar = TestSearch "Search on simple graph with partial branch" simple [0,1] 2 5 [0,1,2] [0,1,2] [0,1,2]
testSimpleLoop = TestSearch "Search on simple graph with a loop" simpleLoop [0] 2 5 [0,1,2] [0,1,2] [0,1,2]
testSimpleImp = TestSearch "Impossible search" simpleLoop [0] 3 5 [] [] []
testComplexDepth0 = TestSearch "Search on graph (small depth)" biparte [0] 4 2 [0,3,4] [0,3,4] [0,3,4]
testComplexDepth1 = TestSearch "Search on graph (high depth)" biparte [0] 4 4 [0,3,4] [0,1,2,4] [0,3,4]
testcomplexLoop0 = TestSearch "Search on graph with loops" complexLoop0 [0] 3 10 [0,1,2,3] [0,1,2,3] [0,1,2,3]
testcomplexLoop1 = TestSearch "Search on graph with loops" complexLoop1 [0] 4 3 [0,2,3,4] [0,2,3,4] [0,2,3,4]
-- testBranching = TestSearch "Search on tree" simpleGraph [0] 7 5 [0,2,4] [0,1,3,4] [0,2,4]
testBranching = TestSearch "Search on tree" simpleGraph [0] 4 5 [0,2,4] [0,1,3,4] [0,2,4]
testGraphBig = TestSearch "Impossible search on big graph" bigGraph [0] 5 50 [] [] []
testGraphStd = TestSearch "Search on big graph" hugeGraph [0] 12 4 [0,3,6,12] [0,1,5,10,12] [0,2,5,11,12]
testGraphDpt = TestSearch "Search on big graph (small depth)" hugeGraph [0] 12 3 [0,3,6,12] [0,3,6,12] [0,2,5,11,12]


testAlphaBetaTerminalWin = TestAlphaBeta "Terminal game (win)"
  [ 1, 0, 1, 0,
    1, 0, 1, 1,
    1, 0, 0, 1,
    1, 1, 1, 0] humanPlayer 1

testAlphaBetaTerminalDraw = TestAlphaBeta "Terminal game (draw)"
  [ 1, 1, 0, 0,
    1, 0, 1, 1,
    0, 0, 0, 1,
    1, 0, 1, 0] humanPlayer 0

testAlphaBetaTerminalLoss = TestAlphaBeta "Terminal game (loss)"
  [ 1, 0, 1, 0,
    1, 0, 1, 1,
    0, 0, 0, 1,
    1, 0, 1, 0] humanPlayer (-1)

testAlphaBetaForcedWin = TestAlphaBeta "Quasi-terminal game (forced win)"
  [-1, 0, 1,-1,
    1, 0, 1, 1,
    1, 1, 0, 1,
    1, 0, 1, 0] humanPlayer 1

testAlphaBetaForcedDraw = TestAlphaBeta "Quasi-terminal game (forced draw)"
  [-1,-1, 0, 0,
    0, 1, 1, 1,
    0, 0, 0, 1,
    1, 0, 1, 0] humanPlayer 0

testAlphaBetaForcedLoss = TestAlphaBeta "Quasi-terminal game (forced loss)"
  [ 1, 0,-1,-1,
    1, 1, 0, 1,
    1, 0, 0, 1,
    0, 1, 0, 0] humanPlayer (-1)

testAlphaBetaDraw0 = TestAlphaBeta "Normal game (draw) (2 moves left)"
  [ 1, 0,-1,-1,
    1, 0, 1, 1,
    1, 0, 0, 1,
    0, 1, 0, 0] humanPlayer 0

testAlphaBetaDraw1 = TestAlphaBeta "Normal game (draw) (2 moves left)"
  [-1,-1,-1,-1,
   -1,-1,-1,-1,
    1, 1, 0, 1,
    0, 1, 0, 0] humanPlayer 0


testNextEmpty = TestNext [] emptyGraph []
testNextSimple0 = TestNext [0] simple [[0,1]]
testNextSimple1 = TestNext [0,1] simple [[0,1,2]]
testNextGraph0 = TestNext [0] simpleGraph [[0,1],[0,2]]
testNextGraph1 = TestNext [0,1] simpleGraph [[0,1,3]]

testCheckArrivalTrue0 = TestCheckArrival 0 0 True
testCheckArrivalTrue1 = TestCheckArrival 1 1 True
testCheckArrivalFalse0 = TestCheckArrival 0 1 False
testCheckArrivalFalse1 = TestCheckArrival 1 2 False
testCheckArrivalFalse2 = TestCheckArrival 1 0 False

testExploredTrue = TestExplored 0 [1, 0, 3] True
testExploredFalse = TestExplored 0 [1, 2, 3] False
testExploredEmpty = TestExplored 0 [] False
testExploredHugeTrueH = TestExplored 0 [0..10000] True
testExploredHugeTrueT = TestExplored 0 [10000,9999..0] True
testExploredHugeFalse = TestExplored 0 [1..10000] False

testCostEmpty = TestCost emptyGraph [] 0
testCostSimple0 = TestCost simple [0,1] 1
testCostSimple1 = TestCost simple [0,1,2] 2
testCostGraph0 = TestCost hugeGraph [0,3,6] 5
testCostGraph1 = TestCost hugeGraph [1,5,10,12] 5
testCostGraph2 = TestCost hugeGraph [0,1,5] 4

testGetHRSimple0 = TestGetHR [0] 0 0
testGetHRSimple1 = TestGetHR [1,2] 1 2

testEvalHuman = TestEval [1,1,1,1,0,1,1,0,1,0,0,1,1,1,0,0] 1
testEvalComp = TestEval [1,1,0,0,1,1,0,0,1,0,0,1,0,1,0,1] (-1)
testEvalDraw = TestEval [1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1] 0


testsListNext :: [TestNext]
testsListNext =
  [
    testNextEmpty
  , testNextSimple0
  , testNextSimple1
  , testNextGraph0
  , testNextGraph1
  ]

testsListCheckArrival :: [TestCheckArrival]
testsListCheckArrival =
  [
    testCheckArrivalTrue0
  , testCheckArrivalTrue1
  , testCheckArrivalFalse0
  , testCheckArrivalFalse1
  , testCheckArrivalFalse2
  ]

testsListExplored :: [TestExplored]
testsListExplored =
  [
    testExploredTrue
  , testExploredFalse
  , testExploredEmpty
  , testExploredHugeTrueH
  , testExploredHugeTrueT
  , testExploredHugeFalse
  ]

testsListCost :: [TestCost]
testsListCost =
  [
    testCostEmpty
  , testCostSimple0
  , testCostSimple1
  , testCostGraph0
  , testCostGraph1
  , testCostGraph2
  ]

testsListGetHR :: [TestGetHR]
testsListGetHR =
  [
    testGetHRSimple0
  , testGetHRSimple1
  ]

testsListEval :: [TestEval]
testsListEval =
  [
    testEvalHuman
  , testEvalComp
  , testEvalDraw
  ]

testsListSearch :: [TestSearch]
testsListSearch =
  [ 
    testSimple
  , testSimpleLoop
  , testSimpleMid
  , testSimplePar
  , testSimpleImp
  , testComplexDepth0
  , testComplexDepth1
  , testcomplexLoop0
  , testcomplexLoop1
  , testSimpleImp
  , testBranching
  , testGraphBig
  , testGraphStd
  , testGraphDpt
  ]

testsListAlphaBeta :: [TestAlphaBeta]
testsListAlphaBeta =
  [
    testAlphaBetaTerminalWin
  , testAlphaBetaTerminalDraw
  , testAlphaBetaTerminalLoss
  , testAlphaBetaForcedWin
  , testAlphaBetaForcedDraw
  , testAlphaBetaForcedLoss
  , testAlphaBetaDraw0
  -- , testAlphaBetaDraw1
  ]

