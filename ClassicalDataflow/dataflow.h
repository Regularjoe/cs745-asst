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

class Lattice;
class LatticeElem;

class Lattice
{
public:
  int size;
  bool backward;
  bool intersect;
  LatticeElem* top;
  Lattice(int s, bool b, bool i);
};

class LatticeElem
{
public:
  std::vector<bool> val;
  Lattice* lattice;
  LatticeElem(const std::vector<bool>& v, Lattice* l);
  LatticeElem meet(const LatticeElem& other);
};

namespace llvm
{

// Add definitions (and code, depending on your strategy) for your dataflow
// abstraction here.

// Prints a representation of F to raw_ostream O.
void ExampleFunctionPrinter(raw_ostream& O, const Function& F);

}

class DataFlowAnalysis
{
  /*std::vector<LatticeElem*> in;
  std::vector<LatticeElem*> out;
  std::vector<LatticeElem*> prev;
  
  in = vector<LatticeElems> (numberOfBlocks)
  out = vector<LatticeElems> (numberOfBlocks)
  prev = vector<LatticeElems> (numberOfBlocks +1) //Blocks that lead into this block
                                                  //One of the bits represents the start
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

  Display 
    foreach block
      print lattice.display(in[block])
      print information within block (important if we are printing after each instruction) 
      print lattice.display(out[block])
 */
  
};

#endif
