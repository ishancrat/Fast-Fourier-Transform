module multiplierFloat(productOut, input1, input2);
input [31:0] input1, input2;
output reg [31:0] productOut;
reg [47:0] productTemp; //max possible 48 bits
reg tempExponent = 1'b0;

/* infinity => 0/1 11111111 00000000000000000000000
	NAN      => 0/1 11111111 (anything other than all 0s) ; here: 7FC00000*/
	
always @(input1 or input2)
begin
	tempExponent = 1'b0;
	if (~(input1 && input2)) //if any one is zero, return zero
		if((&input1[30:23] && |input1[22:0]) || (&input2[30:23] && |input2[22:0])) //if another NAN, then ans is NAN
			productOut = {12'h7FC,20'b0};
		else
			productOut = {32{1'b0}};
		
	else if ((&input1[30:23] && |input1[22:0]) || (&input2[30:23] && |input2[22:0])) //checks if any input is NAN
			productOut = {12'h7FC,20'b0};
		
	else if ((&input1[30:23] && ~(|input1[22:0])) && (&input2[30:23] && ~(|input2[22:0]))) //if both infinity
			productOut = {(input1[31] ^ input2[31]),{8{1'b1}},{23{1'b0}}}; //if same sign, output + else negative

	else if ((&input1[30:23] && ~(|input1[22:0])) || (&input2[30:23] && ~(|input2[22:0]))) //pos or neg infinite
		productOut = (input1[30:0] == {{8{1'b1}},{23{1'b0}}})? {{input1[31]},{8{1'b1}},{23{1'b0}}} : {input2[31],{8{1'b1}},{23{1'b0}}}; //if input1 is (+-)inf, then assign same value, else that of input2

	else
		begin
		productOut[31] = input1[31] ^ input2[31]; //XORing to get the sign bit
		productTemp = {1'b1,input1[22:0]} * {1'b1,input2[22:0]}; //product of mantissa (added 1 before for the entire number)

		if (productTemp[47] == 1) //to check if normalization is needed (1=>extra bit changed)
		begin
			productOut[22:0] = productTemp[46:24];
			tempExponent = 1'b1; //exponent increase after normalization
		end
		else
			productOut[22:0] = productTemp[45:23];
			
		productOut[30:23] = input1[30:23] + input2[30:23] + tempExponent - 8'd127; //expOut = exp1 + exp2 + productExp - bias(127d)
	end
end

endmodule