module test;

  reg clk = 0;
  wire ws_data;
  wire ws_data_n;

  initial begin
     $dumpfile("test.vcd");
     $dumpvars(0, ws_data, ws_data_n);
     # 20
     # 10
     # 2;

	 repeat (20) begin
     end

     $finish;
  end

  top uut (
	.clk(clk),
	.ws_data(ws_data),
	.ws_data_n(ws_data_n)
  );

  /* Make a regular pulsing clock. */
  always #1 clk = !clk;

endmodule // test

