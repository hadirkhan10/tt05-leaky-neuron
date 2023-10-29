module fsm (
  input  wire [6:0] config,
  input  wire       rst_n,
  input  wire       clk,
  output wire [1:0]  state
);

/* always @(posedge clk) begin */
/*   state <= 0; */
/* end */
assign state = 'd0;
endmodule
