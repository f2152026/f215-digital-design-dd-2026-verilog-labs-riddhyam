module cla64_flat(
    input  [63:0] a,
    input  [63:0] b,
    input         cin,
    output [63:0] sum,
    output        cout
);

    wire [63:0] p;
    wire [63:0] g;
    wire [64:0] c;

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = cin;

    genvar i;

    generate
        for (i = 0; i < 64; i = i + 1) begin : carry_logic
            assign c[i+1] = g[i] | (p[i] & c[i]);
        end
    endgenerate

    assign sum = p ^ c[63:0];
    assign cout = c[64];

endmodule