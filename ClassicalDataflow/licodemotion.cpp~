// 15-745 S14 Assignment 3: LICodeMotion.cpp
// Group: aebtekar, auc
////////////////////////////////////////////////////////////////////////////////

#include "llvm/IR/Function.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/PassAnalysisSupport.h"
#include "llvm/ADT/SmallVector.h"

#include "dataflow.h"
#include "dominators.cpp"

using namespace llvm;

namespace {

class LICodeMotion : public LoopPass {
 public:
  static char ID;

  LICodeMotion() : LoopPass(ID) { }

  virtual bool runOnLoop(Loop* loop, LPPassManager& lpm) {
    Dominators& dom = getAnalysis<Dominators>();
    
    //SmallVectorImpl<BasicBlock*> exitBlocks;
    //loop->getExitingBlocks(exitBlocks);
    
    
    
    // Did not modify the incoming Function.
    return false;
  }

  virtual void getAnalysisUsage(AnalysisUsage& AU) const {
    AU.setPreservesCFG();
    // required analyses
    AU.addRequired<LoopInfo>();
    AU.addRequired<Dominators>();
  }

 private:
};

char LICodeMotion::ID = 0;
RegisterPass<LICodeMotion> Y("cd-licodemotion", "15745 Loop Invariant Code Motion");

}
