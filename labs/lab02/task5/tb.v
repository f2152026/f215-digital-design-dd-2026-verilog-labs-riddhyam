// tb.v
// Self-checking testbench for the 4-bit ALU.

module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  // Instantiate ALU
  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  integer errors;

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Self-checking task
  task check;
    input [3:0] a_val;
    input [3:0] b_val;
    input       op_val;
    input [3:0] expected;

    begin
      t_a  = a_val;
      t_b  = b_val;
      t_op = op_val;

      #1;

      if (t_result !== expected) begin
        $display(
          "ERROR: a=%d b=%d op=%b | result=%d expected=%d",
          t_a, t_b, t_op, t_result, expected
        );
        errors = errors + 1;
      end
    end
  endtask

  initial begin

    errors = 0;

    // ------------------------------------------------
    // Test 1: Addition
    // ------------------------------------------------

    check(4'd3, 4'd2, 1'b0, 4'd5);
    check(4'd7, 4'd4, 1'b0, 4'd11);

    // ------------------------------------------------
    // Test 2: Toggle ONLY op
    //
    // a and b stay the same.
    // This specifically tests whether the ALU responds
    // when op changes.
    // ------------------------------------------------

    t_a  = 4'd5;
    t_b  = 4'd3;
    t_op = 1'b0;

    #1;

    if (t_result !== 4'd8) begin
      $display(
        "ERROR: addition setup failed: a=%d b=%d op=%b | result=%d expected=8",
        t_a, t_b, t_op, t_result
      );
      errors = errors + 1;
    end

    // Change ONLY op.
    t_op = 1'b1;

    #1;

    if (t_result !== 4'd2) begin
      $display(
        "ERROR: op-change test: a=%d b=%d op=%b | result=%d expected=2",
        t_a, t_b, t_op, t_result
      );
      errors = errors + 1;
    end

    // ------------------------------------------------
    // Test 3: Subtraction
    // ------------------------------------------------

    check(4'd9, 4'd4, 1'b1, 4'd5);
    check(4'd7, 4'd2, 1'b1, 4'd5);
    check(4'd3, 4'd5, 1'b1, 4'd14);

    // ------------------------------------------------
    // Test 4: More addition/subtraction cases
    // ------------------------------------------------

    check(4'd0, 4'd0, 1'b0, 4'd0);
    check(4'd15, 4'd1, 1'b0, 4'd0);
    check(4'd15, 4'd1, 1'b1, 4'd14);
    check(4'd0, 4'd1, 1'b1, 4'd15);

    if (errors == 0)
      $display("PASS: All ALU tests passed.");
    else
      $display("FAIL: %0d error(s) found.", errors);

    $finish;

  end

  initial begin
    $monitor(
      $time,
      " a=%d b=%d op=%b | result=%d",
      t_a, t_b, t_op, t_result
    );
  end

endmodule