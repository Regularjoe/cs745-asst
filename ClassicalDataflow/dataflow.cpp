// 15-745 S14 Assignment 2: dataflow.cpp
// Group: aebtekar, auc
////////////////////////////////////////////////////////////////////////////////

#include "dataflow.h"

Lattice::Lattice(int s, bool b, bool i)
{
  size = s;
  backward = b;
  intersect = i;
  top = new LatticeElem(std::vector<bool>(size,intersect), this);
}

LatticeElem::LatticeElem(const std::vector<bool>& v, Lattice* l)
{
  val = v;
  lattice = l;
}

LatticeElem LatticeElem::meet(const LatticeElem& other)
{
  LatticeElem ret = *this;
  /*for (int i = 0; i < val.size(); ++i)
  {
    if (lattice->intersect)
      ret.val[i] &= other.val[i];
    else
      ret.val[i] |= other.val[i];
  }*/
  return ret;
}

namespace llvm {

// Add code for your dataflow abstraction here (if necessary).

void PrintInstructionOps(raw_ostream& O, const Instruction* I) {
  O << "\nOps: {";
  if (I != NULL) {
    for (Instruction::const_op_iterator OI = I->op_begin(), OE = I->op_end();
        OI != OE; ++OI) {
      const Value* v = OI->get();
      v->print(O);
      O << ";";
    }
  }
  O << "}\n";
}

void ExampleFunctionPrinter(raw_ostream& O, const Function& F) {
  for (Function::const_iterator FI = F.begin(), FE = F.end(); FI != FE; ++FI) {
    const BasicBlock* block = FI;
    O << block->getName() << ":\n";
    const Value* blockValue = block;
    PrintInstructionOps(O, NULL);
    for (BasicBlock::const_iterator BI = block->begin(), BE = block->end();
        BI != BE; ++BI) {
      BI->print(O);
      PrintInstructionOps(O, &(*BI));
    }
  }
}

void forwardSearch(const Function& F, Lattice* lattice)
{
  size_t numBlocks = F.size();
  std::vector<LatticeElem> in(numBlocks, *lattice->top);
  std::vector<LatticeElem> out(numBlocks, *lattice->top);
  std::vector<LatticeElem> prev(numBlocks, *lattice->top);
  
    Initiate(domain, direction, transfer, mergeFunction, boundary, top)
    lattice = createLattice(numberOfBlocks, domain, XXX)
    foreach block 
      out[block] = top
      foreach nextBlock (block we can potentially lead into)
        if(direction = forwards)
          prev[nextBlock] = prev[nextBlock] && bitIndex of block
        else(direction = backwards)
          prev[block] = prev[block] && bitIndex of nextBlock
      if(we are the first block)
        prev[block] = prev[block] && bitIndex of start
  Run
    while(something has changed last round)
      foreach block (reverse order if direction = backwards)
         foreach previousBlock
           in[block] = mergeFunction(in[block], in[prevBlock])
           out[block] = transferFunction(in[block], block)
}

}
