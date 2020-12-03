`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 12:30:53 PM
// Design Name: 
// Module Name: tfc_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// We define clock period as the simulation timescale is 1ns
// so 1 second is 1,000,000
//`define clk_period 1000000;

module tfc_tb();
    reg clk;
    reg rst;
    wire [2:0] light_A;
    wire [2:0] light_B;
    
    traffic_light TRAFFIC (
        .rst(rst),
        .clk(clk),
        .light_A(light_A),
        .light_B(light_B)
    );
    
    initial clk = 1;
    always #500000000 clk = ~clk;
    
    initial begin
    rst = 0;
    #1000000000 ;
    
    rst = 1;
    #200000000000;
    
    $1000000000000000000finish;
    end
    
endmodule
