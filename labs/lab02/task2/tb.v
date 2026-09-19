// tb.v
// Testbench for the LUT.

module tb;

  // DUT inputs and outputs
  reg [1:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate LUT
  // Instance is named DUT because the waveform configuration
  // below refers to DUT.
  lut DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Apply all possible inputs
  initial begin

    t_sel = 2'b00;
    #5;

    t_sel = 2'b01;
    #5;

    t_sel = 2'b10;
    #5;

    t_sel = 2'b11;
    #5;

    $finish;

  end

  initial
    $monitor($time, " sel=%b | dout=%b (%0d)",
             t_sel, t_dout, t_dout);

endmodule