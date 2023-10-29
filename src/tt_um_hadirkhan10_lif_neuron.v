`default_nettype none

module tt_um_hadirkhan10_lif_neuron (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire [6:0] config_wire;
    // use bidirectionals as outputs
    assign uio_oe = 8'b00000001;
    assign config_wire = uio_in[1:7];

    wire [1:0] state_wire;

    // instantiate the neuron
    lif_neuron neuron (
      .clk(clk), 
      .rst_n(rst_n),
      .current(ui_in),
      .next_state(uo_out),
      .spike(uio_out[0])
    );

    fsm fsm0 (
      .clk(clk),
      .rst_n(rst_n),
      .config(config_wire),
      .state(state_wire)
    );

endmodule
