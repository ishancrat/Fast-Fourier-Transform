module mainCalc(inputVector,o1,o2,o3,o4);
input [255:0]inputVector; //8 numbers, 32 bit each //assuming only real inputs
//output [511:0]out; //output is complex valued
output [63:0]o1,o2,o3,o4;
wire [511:0]out;

// Distribution of 8 numbers in the input vector : DIT FFT
// -- N0 : 255:224
// -- N1 : 223:192
// -- N2 : 191:160
// -- N3 : 159:128
// -- N4 : 127:96
// -- N5 : 95:64
// -- N6 : 63:32
// -- N7 : 31:0

reg[31:0] negOne = 32'hBF800000; //value of negative 1

reg[63:0]W0 = {32'h3F800000,32'h0}; //real and img parts of W0 
reg[63:0]W1 = {32'h3F350481,32'hBF350481};
reg[63:0]W2 = {32'h0,32'hBF800000};
reg[63:0]W3 = {2{32'hBF350481}};
reg[63:0]W4 = {32'hBF800000,32'h0};
reg[63:0]W5 = {32'hBF350481,32'h3F350481};
reg[63:0]W6 = {32'h0,32'h3F800000};
reg[63:0]W7 = {2{32'h3F350481}};  

//module multiplierFloat(productOut, input1, input2);

wire[63:0]L0; wire[63:0]M0; wire[63:0]I0; wire[63:0]N0; assign L0[31:0] = 32'd0;
wire[63:0]L1; wire[63:0]M1; wire[63:0]I1; wire[63:0]N1; assign L1[31:0] = 32'd0;
wire[63:0]L2; wire[63:0]M2; wire[63:0]I2; wire[63:0]N2; assign L2[31:0] = 32'd0;
wire[63:0]L3; wire[63:0]M3; wire[63:0]I3; wire[63:0]N3; assign L3[31:0] = 32'd0;
wire[63:0]L4; wire[63:0]M4; wire[63:0]I4; wire[63:0]N4; assign L4[31:0] = 32'd0;
wire[63:0]L5; wire[63:0]M5; wire[63:0]I5; wire[63:0]N5; assign L5[31:0] = 32'd0;
wire[63:0]L6; wire[63:0]M6; wire[63:0]I6; wire[63:0]N6; assign L6[31:0] = 32'd0;
wire[63:0]L7; wire[63:0]M7; wire[63:0]I7; wire[63:0]N7; assign L7[31:0] = 32'd0;

universalAdder adder1(L0[63:32],inputVector[255:224],inputVector[127:96]);
universalAdder adder2(L1[63:32],inputVector[255:224],{~inputVector[127],inputVector[126:96]}); //negation
universalAdder adder3(L2[63:32],inputVector[191:160],inputVector[63:32]);
universalAdder adder4(L3[63:32],inputVector[191:160],{~inputVector[63],inputVector[62:32]});
universalAdder adder5(L4[63:32],inputVector[223:192],inputVector[95:64]);
universalAdder adder6(L5[63:32],inputVector[223:192],{~inputVector[95],inputVector[94:64]});
universalAdder adder7(L6[63:32],inputVector[159:128],inputVector[31:0]);
universalAdder adder8(L7[63:32],inputVector[159:128],{~inputVector[31],inputVector[30:0]});

complexMultiplier multiplier1(I0,L2,W0);
complexMultiplier multiplier2(I1,L3,W2);
complexMultiplier multiplier3(I2,L2,W4);
complexMultiplier multiplier4(I3,L3,W6);
complexMultiplier multiplier5(I4,L6,W0);
complexMultiplier multiplier6(I5,L7,W2);
complexMultiplier multiplier7(I6,L6,W4);
complexMultiplier multiplier8(I7,L7,W6);

complexAdder compAdder1(M0,L0,I0);
complexAdder compAdder2(M1,L1,I1);
complexAdder compAdder3(M2,L0,I2);
complexAdder compAdder4(M3,L1,I3);
complexAdder compAdder5(M4,L4,I4);
complexAdder compAdder6(M5,L5,I5);
complexAdder compAdder7(M6,L4,I6);
complexAdder compAdder8(M7,L5,I7);

complexMultiplier multiplier9(N0,M4,W0);
complexMultiplier multiplier10(N1,M5,W1);
complexMultiplier multiplier11(N2,M6,W2);
complexMultiplier multiplier12(N3,M7,W3);
complexMultiplier multiplier13(N4,M4,W4);
complexMultiplier multiplier14(N5,M5,W5);
complexMultiplier multiplier15(N6,M6,W6);
complexMultiplier multiplier16(N7,M7,W7);

complexAdder compAdder9(out[511:448],M0,N0);
complexAdder compAdder10(out[447:384],M1,N1);
complexAdder compAdder11(out[383:320],M2,N2);
complexAdder compAdder12(out[319:256],M3,N3);
complexAdder compAdder13(out[255:192],M0,N4);
complexAdder compAdder14(out[191:128],M1,N5);
complexAdder compAdder15(out[127:64],M2,N6);
complexAdder compAdder16(out[63:0],M3,N7);

assign o1 = out[255:192];
assign o2 = out[191:128];
assign o3 = out[127:64];
assign o4 = out[63:0];
endmodule