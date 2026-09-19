// tb.v
// Testbench for the 2-to-1 multiplexer.

module tb;

  // DUT inputs
  reg t_i0, t_i1, t_s;

  // DUT output
  wire t_y;

  // Instantiate DUT
  DUT U1 (
    .I0(t_i0),
    .I1(t_i1),
    .S(t_s),
    .Y(t_y)
  );

  // Waveform dump configuration
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  // Apply all 8 combinations
  initial begin

    t_i0 = 0;
    t_i1 = 0;
    t_s  = 0;
    #5;

    t_i0 = 0;
    t_i1 = 0;
    t_s  = 1;
    #5;

    t_i0 = 0;
    t_i1 = 1;
    t_s  = 0;
    #5;

    t_i0 = 0;
    t_i1 = 1;
    t_s  = 1;
    #5;

    t_i0 = 1;
    t_i1 = 0;
    t_s  = 0;
    #5;

    t_i0 = 1;
    t_i1 = 0;
    t_s  = 1;
    #5;

    t_i0 = 1;
    t_i1 = 1;
    t_s  = 0;
    #5;

    t_i0 = 1;
    t_i1 = 1;
    t_s  = 1;
    #5;

    $finish;

  end

  // Monitor output
  initial begin
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b",
             t_i0, t_i1, t_s, t_y);
  end

endmodule