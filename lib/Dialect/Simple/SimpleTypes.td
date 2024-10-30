#ifndef LIB_DIALECT_SIMPLE_SIMPLETYPES_TD_
#define LIB_DIALECT_SIMPLE_SIMPLETYPES_TD_

include "SimpleDialect.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
class Simple_Type<string name, string typeMnemonic> : TypeDef<Simple_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def MySimpleInt : Simple_Type<"Simple", "sint"> {
  let summary = "A simple dialect only with i32 data";

  let description = [{
    just a test
  }];

  // "int" can be any string containing a C++ type
  // $payload will be picked up by mlir and will be used in the generated code
  // and can be referenced throughout the rest of tablegen setup
  let parameters = (ins "int":$payload);

  // this defines the parser and lexer. The backticks define literals that are printed and parsed
  // this will turn into `simple.simple<10>` for example.
  let assemblyFormat = "`<` $payload `>`";
}

#endif  // LIB_DIALECT_SIMPLE_SIMPLETYPES_TD_
