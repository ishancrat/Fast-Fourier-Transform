module universalAdder(sum,input1,input2,temp1,temp2);
input [31:0]input1,input2;
output reg [31:0]sum;
output wire [31:0]temp1,temp2;

reg [7:0]exponent1,exponent2,exponentOut;
reg [7:0]expDiff;
reg ov;
integer i;
wire check = 1'b1;
reg [23:0]mantissa1,mantissa2,mantissaOut;


assign temp1 = input1;
assign temp2 = input2;

always @(input1 or input2) 
begin
	mantissa1 = {1'b1,input1[22:0]};
	mantissa2 = {1'b1,input2[22:0]};
	exponent1 = input1[30:23];
	exponent2 = input2[30:23];
	
	if (exponent1 > exponent2)
	begin
		exponentOut = exponent1;
		expDiff = exponent1 - exponent2;
		mantissa2 = mantissa2 >> expDiff;
	end
	else
	begin
		exponentOut = exponent2;
		expDiff = exponent2 - exponent1;
		mantissa1 = mantissa1 >> expDiff;
	end
	
	{ov,mantissaOut} = (input1[31] ~^ input2[31])?(mantissa1 + mantissa2) : ((mantissa1 > mantissa2)?mantissa1 - mantissa2 : mantissa2 - mantissa1);
	//above line -> if same sign then add, if different sign, then subtract smaller mantissa from larger one
	sum[31] = (input1[31] ~^ input2[31])?input1[31]:((mantissa1 > mantissa2)?input1[31]:input2[31]);
	

	//similarly for the signed bit
	
	if (~(input1 && input2)) //any one or both zero
	begin
		sum = (input1 == 32'h0) ? input2 : input1;
		$display("zero zerro case running");
		//exponentOut = (input1 == 32'h0) ? exponent2 : exponent1;
		
	end
	else if ((mantissa1 == mantissa2) && (input1[31] ^ input2[31])) //if same number subtraction
	begin
		mantissaOut = 23'h0;
		sum[31] = 1'b0;
		exponentOut = 8'h0;
		sum[30:0] = {exponentOut,mantissaOut[22:0]};
	end
	else
	begin
		if ((input1[31] ^ input2[31]) && mantissaOut[23]==0) //normalization if subtraction is performed
		begin
			for (i=0;i<22;i=i+1) //keeps shifting left until '1' is at the invisible bit
				begin
					if (mantissaOut[23] == 1'b0)
					begin
					mantissaOut = mantissaOut <<1;
					exponentOut = exponentOut - 1;
					end
				end
//			while (mantissaOut[23]==1'b0)
//			begin
//				mantissaOut = mantissaOut << 1;
//				exponentOut = exponentOut - 1;
//			end
		end
		
		else if (ov==1 && (input1[31] ~^ input2[31])) //normalization if addition is performed
		begin
			exponentOut = exponentOut + 1;
			mantissaOut = mantissaOut >> 1;
		end
		
		sum[30:0] = {exponentOut,mantissaOut[22:0]};
	end
	
	
end

endmodule