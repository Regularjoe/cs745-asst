// 15-745 S14 Assignment 2: dataflow.h
// Group: aebtekar, auc
////////////////////////////////////////////////////////////////////////////////

#ifndef __CLASSICAL_DATAFLOW_DATAFLOW_H__
#define __CLASSICAL_DATAFLOW_DATAFLOW_H__

#include <stdio.h>
#include <vector>

#include "llvm/IR/Instructions.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/ValueMap.h"
#include "llvm/Support/CFG.h"

namespace llvm {

// Add definitions (and code, depending on your strategy) for your dataflow
// abstraction here.

// Prints a representation of F to raw_ostream O.
void ExampleFunctionPrinter(raw_ostream& O, const Function& F);

}

class Lattice;
class LatticeElem
{
public:
  std::vector<bool> val;
  Lattice* lattice;
  LatticeElem(std::vector<bool> v, Lattice* l) : val(v), lattice(l) {}
  LatticeElem meet(const LatticeElem& other);
};
class Lattice
{
public:
  int size;
  bool backward;
  bool intersect;
  LatticeElem top;
  Lattice(int s, bool b, bool i) : size(s),backward(b),intersect(i)
  {
    top = LatticeElem(std::vector<bool>(size,intersect), this);
  }
};

class DataFlowAnalysis
{
  
};

#endif
