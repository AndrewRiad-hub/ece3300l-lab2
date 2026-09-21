
module addsub4 (
	       input [3:0] A, B,
	       input subsel,
	       output [3:0] X,
	       output cout, ovf
	       );

 wire [3:0] B_modified;

 
    assign B_modified = B ^ {4{subsel}};
	
 	add4 adder_subtractor (
        .carryin(subsel),
        .X(A),
        .Y(B_modified),
        .S(X),
        .carryout(cout),
        .ovf(ovf)
    );
   
endmodule

