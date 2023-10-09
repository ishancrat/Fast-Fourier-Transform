module complexAdder(outComplex,inComplex1,inComplex2);
input [63:0] inComplex1,inComplex2;
output [63:0] outComplex;

universalAdder adderC(outComplex[63:32],inComplex1[63:32],inComplex2[63:32]);
universalAdder adderD(outComplex[31:0],inComplex1[31:0],inComplex2[31:0]);

endmodule