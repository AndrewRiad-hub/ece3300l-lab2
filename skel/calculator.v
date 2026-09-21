
module calculator (
		   input [1:0]	OP,
		   input [3:0]	A, B,
		   output [9:0]	out
		   );

   wire				cout, ovf;  // carry_out and overflow
   wire [3:0]			outa;  // adder output
   wire [7:0]			outm;  // multiplier output

 addsub4 addsub_unit (
        .A(A),
        .B(B),
        .subsel(OP[0]),
        .X(outa),
        .cout(cout),
        .ovf(ovf)
    );

  
    mult4 multiplier_unit (
        .A(A),
        .B(B),
        .X(outm)
    );

 
    mux10 output_mux (
        .in0({ovf, cout, 4'b0000, outa}),
        .in1({2'b00, outm}),
        .sel(OP[1]),
        .out(out)
    );
	
endmodule // calculator

