`default_nettype none

module top (
	input  clk,
    output reg ws_data,
    output wire ws_data_n
);
    reg [1:0] state = 0;
    initial ws_data = 0;
    assign ws_data_n = ~ws_data;
    always @(posedge clk) begin
        case (state)
            2'd0: begin ws_data <= 1; state <= 2'd1; end // 1st high
            2'd1: begin ws_data <= 1; state <= 2'd2; end // 2nd high
            2'd2: begin ws_data <= 0; state <= 2'd0; end // 1 low
        endcase
    end
endmodule
