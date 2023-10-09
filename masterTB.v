module masterTB;
//stored at fast fourier transform folder
  reg [31:0] in;
  wire [511:0]out;
 
  fastFourierTransform f1(.in(in),.out(out));
 
  initial begin $dumpfile("full_tb.vcd");$dumpvars(); end

// insert all the inputs 
  initial begin in=32'b0;end

 initial 
 begin 
 $monitor("Real, Imaginary: %h ",out[511:448] );
 #10
 $monitor("Real, Imaginary: %h ",out[447:384] );
#10
 $monitor("Real, Imaginary: %h ",out[383:320] );
#10
 $monitor("Real, Imaginary: %h ",out[319:256] );
 #10
 $monitor("Real, Imaginary: %h ",out[255:192] );
 #10
 $monitor("Real, Imaginary: %h ",out[191:128] );
 #10
 $monitor("Real, Imaginary: %h ",out[127:64] );
  #10
 $monitor("Real, Imaginary: %h ",out[63:0] );
end

 endmodule