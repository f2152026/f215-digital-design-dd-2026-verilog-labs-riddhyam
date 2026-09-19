// tb.v
// Self-checking testbench for 2-bit magnitude comparator.

module tb;

  reg  [1:0] t_A;
  reg  [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  // Instantiate comparator
  comp2 DUT (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  integer i;
  integer j;
  integer errors;

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Test every possible combination of A and B
  initial begin

    errors = 0;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin

        t_A = i;
        t_B = j;

        #1;

        if (t_GT !== (i > j)) begin
          $display("ERROR: A=%b B=%b | GT=%b expected=%b",
                   t_A, t_B, t_GT, (i > j));
          errors = errors + 1;
        end

        if (t_LT !== (i < j)) begin
          $display("ERROR: A=%b B=%b | LT=%b expected=%b",
                   t_A, t_B, t_LT, (i < j));
          errors = errors + 1;
        end

        if (t_EQ !== (i == j)) begin
          $display("ERROR: A=%b B=%b | EQ=%b expected=%b",
                   t_A, t_B, t_EQ, (i == j));
          errors = errors + 1;
        end

      end
    end

    if (errors == 0)
      $display("PASS: All comparator tests passed.");
    else
      $display("FAIL: %0d error(s) found.", errors);

    $finish;

  end

endmodule