
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

	wire carry[2:0];

	wire unused_ovf[2:0];

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
    	.X({1'b0, partial0[3:1]}),
    	.Y(partial1),
    	.S(sum1),
    	.carryout(carry[0]),
    	.ovf(unused_ovf[0])
	);

    assign X[1] = sum1[0];

   add4 stage2 (
    	.carryin(1'b0),
    	.X({carry[0], sum1[3:1]}),
    	.Y(partial2),
    	.S(sum2),
    	.carryout(carry[1]),
    	.ovf(unused_ovf[1])
	);
	
    assign X[2] = sum2[0];

    add4 stage3 (
    	.carryin(1'b0),
    	.X({carry[1], sum2[3:1]}),
    	.Y(partial3),
    	.S(sum3),
    	.carryout(carry[2]),
    	.ovf(unused_ovf[2])
	);

    assign X[6:3] = sum3;
	assign X[7]   = carry[2];
   
endmodule // mult4

