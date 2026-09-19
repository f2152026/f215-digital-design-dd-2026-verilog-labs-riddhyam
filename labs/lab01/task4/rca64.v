module rca64(
    input  [63:0] a,
    input  [63:0] b,
    input         cin,
    output [63:0] sum,
    output        cout
);

    wire [64:0] c;

    assign c[0] = cin;

    genvar i;

    generate
        for (i = 0; i < 64; i = i + 1) begin : gen_fa

            assign sum[i] = a[i] ^ b[i] ^ c[i];

            assign c[i+1] = (a[i] & b[i]) |
                            (a[i] & c[i]) |
                            (b[i] & c[i]);

        end
    endgenerate

    assign cout = c[64];

endmodule