
module mult4 (
	     input [3:0] A, B,
	     output [7:0] X
	     );

 wire [3:0] partial0;
    wire [3:0] partial1;
    wire [3:0] partial2;
    wire [3:0] partial3;

    wire [3:0] sum1;
    wire [3:0] sum2;
    wire [3:0] sum3;

    wire carry1;
    wire carry2;
    wire carry3;

    wire unused_ovf1;
    wire unused_ovf2;
    wire unused_ovf3;

    // Generate the four partial products.
    assign partial0 = A & {4{B[0]}};
    assign partial1 = A & {4{B[1]}};
    assign partial2 = A & {4{B[2]}};
    assign partial3 = A & {4{B[3]}};

    // The least-significant product bit comes directly
    // from the first partial product.
    assign X[0] = partial0[0];

    add4 stage1 (
        .carryin(1'b0),
        .X(partial1),
        .Y({1'b0, partial0[3:1]}),
        .S(sum1),
        .carryout(carry1),
        .ovf(unused_ovf1)
    );

    assign X[1] = sum1[0];

    add4 stage2 (
        .carryin(1'b0),
        .X(partial2),
        .Y({carry1, sum1[3:1]}),
        .S(sum2),
        .carryout(carry2),
        .ovf(unused_ovf2)
    );

    assign X[2] = sum2[0];

    add4 stage3 (
        .carryin(1'b0),
        .X(partial3),
        .Y({carry2, sum2[3:1]}),
        .S(sum3),
        .carryout(carry3),
        .ovf(unused_ovf3)
    );

    assign X[6:3] = sum3;
    assign X[7]   = carry3;
   
endmodule // mult4

