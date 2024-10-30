#ifndef LIB_DIALECT_SIMPLE_SIMPLEDIALECT_TD_
#define LIB_DIALECT_SIMPLE_SIMPLEDIALECT_TD_

include "mlir/IR/OpBase.td"

def Simple_Dialect : Dialect {
  let name = "simple";
  let summary = "A dialect to represent and do things with numbers";
  let description = [{
    just a test dialect
  }];

  let cppNamespace = "::mlir::tutorial::simple";

  let useDefaultTypePrinterParser = 1;
  let hasConstantMaterializer = 1;
}

#endif  // LIB_DIALECT_SIMPLE_SIMPLEDIALECT_TD_
