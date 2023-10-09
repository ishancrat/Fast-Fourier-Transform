module fastFourierTransform(in,out1,out2,out3,out4);
input [31:0]in; //8 numbers, 32 bit each, all real inputs assumed
output [63:0]out1,out2,out3,out4;

wire [31:0]t1,t2,t3,t4,t5,t6;

wire [255:0] bruh = {32'h40400000, 32'hBF800000,32'h40800000,32'h40C00000,32'h40000000,32'h40E00000,32'h41000000,32'hC0400000};
mainCalc mc(bruh,out1,out2,out3,out4);


//universalAdder mp(out1[63:32],32'hBF800000,32'hC0E00000);

//
//multiplierFloat multiplierA(t1,32'h40400000,32'h0); // ac
//multiplierFloat multiplierB(t2,32'h0,32'h3F800000); // bd
//multiplierFloat multiplierC(t3,32'h40400000,32'h3F800000); // ad
//multiplierFloat multiplierD(t4,32'h0,32'h0); // bc
//
//assign out1 = t1;
//assign t2[31] = ~(t2[31]);
//assign out2 = t2;
//assign out3 = t3;
//assign out4 = t4;
//
//universalAdder udf(out1,t1,{~t2[31],t2[30:0]},out3,out4);
//universalAdder ufdf(out2,t3,t4,t5,t6);

//complexMultiplier cmp(out1,{32'h40400000,32'h0},{32'h0,32'h3F800000});


endmodule