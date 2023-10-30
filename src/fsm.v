module fsm (
  input  wire [6:0]  setting,
  input  wire        rst_n,
  input  wire        clk,
  output reg  [1:0]  state
);

// Define states
parameter IDLE    = 2'b00;
parameter BETA    = 2'b01;
parameter THRESH  = 2'b10;
parameter READ    = 2'b11;

always @(posedge clk) begin
  if (!rst_n) begin
    state <= IDLE;
  end else begin
    case (state)
      IDLE: begin
        if (setting == 6'd1) begin
          state <= BETA;
        end else begin
          state <= IDLE;
        end
      end

      BETA: begin
        if (setting == 6'd2) begin
          state <= THRESH;
        end else begin
          state <= BETA;
        end
      end

      THRESH: begin
        if (setting == 6'd3) begin
          state <= READ;
        end else begin
          state <= THRESH;
        end
      end

      READ: begin
        if (setting == 6'd0) begin
          state <= IDLE;
        end else begin
          state <= READ;
        end
      end
    endcase

  end
end



endmodule
