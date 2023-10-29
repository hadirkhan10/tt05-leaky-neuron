module lif_neuron (
    input  wire [7:0] current,
    input  wire       clk,
    input  wire       rst_n,
    output wire [7:0] next_state,
    output wire       spike
);

reg [7:0] state, threshold;

assign next_state = current + (spike ? 0 : state >> 1);
assign spike = (state >= threshold);

always @(posedge clk) begin
  if (!rst_n) begin
    state <= 0;
    threshold <= 32;
  end else begin
    state <= next_state;
  end
end

endmodule

