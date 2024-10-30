#ifndef LIB_DIALECT_SIMPLE_SIMPLEOPS_TD_
#define LIB_DIALECT_SIMPLE_SIMPLEOPS_TD_

// artifacts are placed in bazel-bin
include "SimpleDialect.td"
include "SimpleTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

// Type constraint for binop arguments: polys, vectors of polys, or
// tensors of polys.
def SimpleOrContainer : TypeOrContainer<MySimpleInt, "simple-or-container">;

// Inject verification that all integer-like arguments are 32-bits
def Has32BitArguments : NativeOpTrait<"Has32BitArguments"> {
  let cppNamespace = "::mlir::tutorial::simple";
}

// this subclasses the Op base class
// we pass Pure
// we pass ElementwiseMappable
// we pass SameOperandsAndResultType
class Simple_BinOp<string mnemonic> : Op<Simple_Dialect, mnemonic, [Pure, ElementwiseMappable, SameOperandsAndResultType]> {
  let arguments = (ins SimpleOrContainer:$lhs, SimpleOrContainer:$rhs);
  let results = (outs SimpleOrContainer:$output);
  let assemblyFormat = "$lhs `,` $rhs attr-dict `:` qualified(type($output))";
  let hasFolder = 1;
  let hasCanonicalizer = 1;
}

def Simple_AddOp : Simple_BinOp<"add"> {
  let summary = "Addition operation between simples.";
}

def IntOrComplex : AnyTypeOf<[AnyInteger, AnyComplex]>;

def Simple_EvalOp : Op<Simple_Dialect, "eval", [AllTypesMatch<["point", "output"]>, Has32BitArguments]> {
  let summary = "Evaluates a simple at a given input value.";
  let arguments = (ins MySimpleInt:$payload, IntOrComplex:$point);
  let results = (outs IntOrComplex:$output);
  let assemblyFormat = "$payload `,` $point attr-dict `:` `(` qualified(type($payload)) `,` type($point) `)` `->` type($output)";
  let hasVerifier = 1;
  let hasCanonicalizer = 1;
}

def Simple_ConstantOp : Op<Simple_Dialect, "constant", [Pure, ConstantLike]> {
  let summary = "Define a constant polynomial via an attribute.";
  let arguments = (ins AnyIntElementsAttr:$coefficients);
  let results = (outs MySimpleInt:$output);
  let assemblyFormat = "$coefficients attr-dict `:` qualified(type($output))";
  let hasFolder = 1;
}


#endif  // LIB_DIALECT_SIMPLE_SIMPLEOPS_TD_
