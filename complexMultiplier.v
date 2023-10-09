module complexMultiplier(outComplex,inComplex1,inComplex2); //to perform multiplications of the type (a+jb)(c+jd)
input [63:0] inComplex1,inComplex2;
output [63:0] outComplex;
// a + jb : inComplex1[63:32] + j*inComplex2[31:0]
// c + jd : inComplex2[63:32] + j*inComplex2[31:0]
// ac + (- bd) +j(ad+bc)

wire[31:0]T1;
wire[31:0]T2;
wire[31:0]T3;
wire[31:0]T4;
reg[31:0]intermediate;
wire[31:0]Treal;
wire[31:0]Timg;

multiplierFloat multiplierA(T1,inComplex1[63:32],inComplex2[63:32]); // ac
multiplierFloat multiplierB(T2,inComplex1[31:0],inComplex2[31:0]); // bd
multiplierFloat multiplierC(T3,inComplex1[63:32],inComplex2[31:0]); // ad
multiplierFloat multiplierD(T4,inComplex1[31:0],inComplex2[63:32]); // bc
//assign T2[31] = ~ T2[31]; //since the product requires -bd for j*j


always @(inComplex1 or inComplex2)
begin
	if (~|T2)
		intermediate = 32'h0;
	else
		intermediate = {~T2[31],T2[30:0]};
		//T2 = {~T2[31],T2[30:0]};
end

//if T2 is zero, then it proceeds as normal
//else, the sign bit is reversed to compensate for j*j => minus sign

universalAdder adderA(Treal,T1,intermediate);
universalAdder adderB(Timg,T3,T4);
assign outComplex = {Treal,Timg};

endmodule