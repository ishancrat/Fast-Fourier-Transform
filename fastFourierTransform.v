module fastFourierTransform(sw0,key1,ssd5,ssd4,ssd3,ssd2,ssd1,ssd0);
//input [31:0]in; //8 numbers, 32 bit each, all real inputs assumed
input sw0,key1;
output reg [6:0]ssd5,ssd4,ssd3,ssd2,ssd1,ssd0;	

//
wire [63:0]out1,out2,out3,out4,out5,out6,out7,out8; //out1 is MSB
reg [6:0]s0,s1,s2,s3,s4,s5;
reg [3:0]temp1,temp2,temp3,temp4;
wire [6:0]ssdVal1,ssdVal2,ssdVal3,ssdVal4;
wire [255:0]bruh = {32'h40400000, 32'h3F800000,32'hC0E00000,32'h40A00000,32'h40C00000,32'h00000000,32'h40000000,32'h40A00000};
//wire [255:0]bruh = {32'hC0400000, 32'h40800000,32'h3F800000,32'h00000000,32'h40000000,32'h40E00000,32'h41000000,32'hC1400000};

mainCalc calc(bruh,out1,out2,out3,out4,out5,out6,out7,out8);

displayKey dk0(temp1,ssdVal1);
displayKey dk1(temp2,ssdVal2);
displayKey dk2(temp3,ssdVal3);
displayKey dk3(temp4,ssdVal4);

//leftmost 7SD displays the number of output ie from 7 to 0
//real is assigned by a small "u" on the upper half of 7SD; imaginary by an inverted "u" on lower half LEDs (2nd Most sign 7SD)

parameter keyF = 7'b0111000,
			 keyT = 7'b1110000,
			 keyD = 7'b1000010,
			 keyI = 7'b1111011,
			 keyreal = 7'b1011100,
			 keyimg  = 7'b1101010,
			 disp0   = 7'b0000001,
			 disp1   = 7'b1001111,
			 disp2   = 7'b0010010,
			 disp3   = 7'b0000110,
			 disp4   = 7'b1001100,
			 disp5   = 7'b0100100,
			 disp6   = 7'b0100000,
			 disp7   = 7'b0001111;
			 

parameter fft = 6'd0,
			 o7r_u = 6'd1, //output7(MSB), real part, upper 4 hex characters
			 o7r_l = 6'd2,
			 o7i_u = 6'd3,
			 o7i_l = 6'd4,
			 o6r_u = 6'd5, //output6, real part, upper 4 hex characters
			 o6r_l = 6'd6,
			 o6i_u = 6'd7,
			 o6i_l = 6'd8,
			 o5r_u = 6'd9, //output5, real part, upper 4 hex characters
			 o5r_l = 6'd10,
			 o5i_u = 6'd11,
			 o5i_l = 6'd12,
			 o4r_u = 6'd13, //output4, real part, upper 4 hex characters
			 o4r_l = 6'd14,
			 o4i_u = 6'd15,
			 o4i_l = 6'd16,
			 o3r_u = 6'd17, //output3, real part, upper 4 hex characters
			 o3r_l = 6'd18,
			 o3i_u = 6'd19,
			 o3i_l = 6'd20,
			 o2r_u = 6'd21, //output2, real part, upper 4 hex characters
			 o2r_l = 6'd22,
			 o2i_u = 6'd23,
			 o2i_l = 6'd24,
			 o1r_u = 6'd25, //output1, real part, upper 4 hex characters
			 o1r_l = 6'd26,
			 o1i_u = 6'd27,
			 o1i_l = 6'd28,
			 o0r_u = 6'd29, //output0, real part, upper 4 hex characters
			 o0r_l = 6'd30,
			 o0i_u = 6'd31,
			 o0i_l = 6'd32;
			 
reg [5:0]state = 6'd0;

always @(state)
begin
	case(state)
		fft:
		begin
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {keyD,keyI,keyT,keyF,keyF,keyT};
		end
		
		o7r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out1[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp7,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o7r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out1[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp7,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o7i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out1[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp7,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o7i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out1[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp7,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o6r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out2[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp6,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o6r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out2[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp6,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o6i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out2[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp6,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o6i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out2[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp6,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o5r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out3[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp5,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o5r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out3[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp5,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o5i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out3[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp5,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o5i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out3[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp5,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o4r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out4[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp4,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o4r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out4[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp4,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o4i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out4[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp4,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o4i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out4[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp4,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o3r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out5[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp3,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o3r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out5[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp3,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o3i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out5[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp3,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o3i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out5[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp3,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o2r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out6[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp2,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o2r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out6[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp2,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o2i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out6[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp2,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o2i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out6[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp2,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o1r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out7[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp1,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o1r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out7[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp1,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o1i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out7[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp1,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o1i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out7[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp1,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o0r_u:
		begin
			{temp1,temp2,temp3,temp4}       = out8[63:48];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp0,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o0r_l:
		begin
			{temp1,temp2,temp3,temp4}       = out8[47:32];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp0,keyreal,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o0i_u:
		begin
			{temp1,temp2,temp3,temp4}       = out8[31:16];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp0,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		o0i_l:
		begin
			{temp1,temp2,temp3,temp4}       = out8[15:0];
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {disp0,keyimg,ssdVal1,ssdVal2,ssdVal3,ssdVal4};
		end
		
		default:
		begin
			{ssd5,ssd4,ssd3,ssd2,ssd1,ssd0} = {keyD,keyI,keyT,keyF,keyF,keyT};
		end
	endcase	
end			
			
//KEY1 IS push BUTTON 1; SW0 IS switch0			
always @(negedge key1)
begin
	case(state)
		fft    : state = sw0 ? o7r_u : o0i_l;
		o7r_u  :	state = sw0 ? o7r_l : fft  ;
		o7r_l  : state = sw0 ? o7i_u : o7r_u;
		o7i_u  : state = sw0 ? o7i_l : o7r_l;
		o7i_l  :	state = sw0 ? o6r_u : o7i_u;
		o6r_u  :	state = sw0 ? o6r_l : o7i_l;
		o6r_l  :	state = sw0 ? o6i_u : o6r_u;
		o6i_u  :	state = sw0 ? o6i_l : o6r_l;
		o6i_l  :	state = sw0 ? o5r_u : o6i_u;
		o5r_u  :	state = sw0 ? o5r_l : o6i_l;
		o5r_l  :	state = sw0 ? o5i_u : o5r_u; 
		o5i_u  :	state = sw0 ? o5i_l : o5r_l;
		o5i_l  :	state = sw0 ? o4r_u : o5i_u;
		o4r_u  :	state = sw0 ? o4r_l : o5i_l;
		o4r_l  :	state = sw0 ? o4i_u : o4r_u;
		o4i_u  :	state = sw0 ? o4i_l : o4r_l;
		o4i_l  :	state = sw0 ? o3r_u : o4i_u;
		o3r_u  : state = sw0 ? o3r_l : o4i_l;
		o3r_l  :	state = sw0 ? o3i_u : o3r_u;
		o3i_u  :	state = sw0 ? o3i_l : o3r_l;
		o3i_l  :	state = sw0 ? o2r_u : o3i_u;	
		o2r_u  :	state = sw0 ? o2r_l : o3i_l;
		o2r_l  :	state = sw0 ? o2i_u : o2r_u;
		o2i_u  :	state = sw0 ? o2i_l : o2r_l;	
		o2i_l  :	state = sw0 ? o1r_u : o2i_u;
		o1r_u  :	state = sw0 ? o1r_l : o2i_l;
		o1r_l  :	state = sw0 ? o1i_u : o1r_u;
		o1i_u  :	state = sw0 ? o1i_l : o1r_l;
		o1i_l  :	state = sw0 ? o0r_u : o1i_u;	
		o0r_u  :	state = sw0 ? o0r_l : o1i_l;
		o0r_l  :	state = sw0 ? o0i_u : o0r_u;
		o0i_u  :	state = sw0 ? o0i_l : o0r_l;	
		o0i_l  :	state = sw0 ? fft   : o0i_u;
	endcase
end
//pushButton1 triggers next state, switch0 determines direction of travel ie LSB to MSB or otherwise

endmodule
