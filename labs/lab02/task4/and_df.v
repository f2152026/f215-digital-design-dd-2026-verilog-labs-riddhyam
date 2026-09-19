// and_df.v
// AND gate using dataflow modeling.

module and_df (
  input a,
  input b,
  output y
);

  assign #5 y = a & b;

endmodule