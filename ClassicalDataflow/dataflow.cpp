// 15-745 S14 Assignment 2: dataflow.cpp
// Group: aebtekar, auc
////////////////////////////////////////////////////////////////////////////////

#include "dataflow.h"

Lattice::Lattice(std::vector<std::string> n, bool i)
{
  size = n.size();
  names = n;
  intersect = i;
  top = Elem(size, intersect);
}

Elem Lattice::meet(const Elem& elem1, const Elem& elem2)
{
  Elem ret(size);
  for (int i = 0; i < ret.size(); ++i)
  {
    if (intersect)
      ret[i] = elem1[i] & elem2[i];
    else
      ret[i] = elem1[i] | elem2[i];
  }
  return ret;
}

void Lattice::print(Elem elem)
{
  std::cout << '{';
  bool first = true;
  for (int i = 0; i < elem.size(); ++i)
  if (elem[i])
  {
    if (first)
      first = false;
    else
      std::cout << ',';
    std::cout << names[i];
  }
  std::cout << '}' << std::endl;
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

void forwardSearch(Function& F, Lattice* lattice, Elem (*transFun)(Instruction*, Elem))
{
  size_t numBlocks = F.size();
  std::map<BasicBlock*, Elem> in;
  std::map<BasicBlock*, Elem> out;
  
  for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
  {
    in[BI] = out[BI] = lattice->top;
  }
  bool change;
  do
  {
    change = false;
    for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
    {
      in[BI] = lattice->top;
      for (pred_iterator PI = pred_begin(BI), PE = pred_end(BI); PI != PE; ++PI)
      {
        BasicBlock* pred = *PI;
        in[BI] = lattice->meet(in[BI], out[pred]);
      }
      Elem elem = in[BI];
      for (ilist_iterator<Instruction> II = BI->begin(), IE = BI->end(); II != IE; ++II)
      {
        elem = transFun(II, elem);
      }
      if (out[BI] != elem);
      {
        out[BI] = elem;
        change = true;
      }
    }
  }
  while (change);
  
  for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
  {
    Elem elem = in[BI];
    for (ilist_iterator<Instruction> II = BI->begin(), IE = BI->end(); II != IE; ++II)
    {
      // check if phi
      lattice->print(elem);
      elem = transFun(II, elem);
    }
    lattice->print(elem);
  }
}

void backwardSearch(Function& F, Lattice* lattice, Elem (*transFun)(Instruction*, Elem))
{
  size_t numBlocks = F.size();
  std::map<BasicBlock*, Elem> in;
  std::map<BasicBlock*, Elem> out;
  
  for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
  {
    in[BI] = out[BI] = lattice->top;
  }
  bool change;
  do
  {
    change = false;
    for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
    {
      out[BI] = lattice->top;
      //TerminatorInst terminator = dyn_cast<TerminatorInst>(BI->getTerminator());
      for (succ_iterator SI = succ_begin(BI), SE = succ_end(BI); SI != SE; ++SI)
      {
        BasicBlock* succ = *SI;
        out[BI] = lattice->meet(out[BI], in[succ]);
      }
      Elem elem = out[BI];
      for (ilist_iterator<Instruction> II = BI->end(), IE = BI->begin(); II != IE; )
      {
        elem = transFun(--II, elem);
      }
      if (in[BI] != elem)
      {
        in[BI] = elem;
        change = true;
      }
    }
  }
  while (change);
  
  for (ilist_iterator<BasicBlock> BI = F.begin(), BE = F.end(); BI != BE; ++BI)
  {
    Elem elem = out[BI];
    lattice->print(elem);
    for (ilist_iterator<Instruction> II = BI->end(), IE = BI->begin(); II != IE; )
    {
      elem = transFun(--II, elem);
      // check if phi
      lattice->print(elem);
    }
  }
}

}
