module lif_neuron (
    input  wire [7:0] ui_in,
    input  wire       clk,
    input  wire       rst_n,
    input  wire [1:0] state,
    output wire [7:0] membrane_out,
    output wire       spike
);

reg [7:0] membrane, threshold, beta;

assign spike = (state == 2'b11) ? membrane >= threshold : 0;

assign membrane_out = membrane;

always @(posedge clk) begin
  case (state) 
    2'b00: begin
      // IDLE STATE
      membrane <= 0;
      threshold <= 0;
      beta <= 0;
    end

    2'b01: begin
      // BETA STATE
      beta <= ui_in;
    end

    2'b10: begin
      // THRESH STATE
      threshold <= ui_in;
    end

    2'b11: begin
      // READ STATE
      membrane <= ui_in + (spike ? 0 : membrane >> beta);
    end

  endcase
end

endmodule

