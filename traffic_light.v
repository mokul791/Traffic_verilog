`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 11:31:50 AM
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input rst,
    input clk,
    output reg [2:0] light_A,
    output reg [2:0] light_B
    );
    
    reg [5:0] state;
    // we do one hot encoding for the 6 states
    localparam S0 = 6'b000001,
               S1 = 6'b000010,
               S2 = 6'b000100,
               S3 = 6'b001000,
               S4 = 6'b010000,
               S5 = 6'b100000;
    // We need one count variable to count seconds
    // assuming we are using 1Hz clock input, i.e. Time = 1/frequency (freq = cycle/per sec)    
    // so when the clock click one time, it will be 1 second
    reg [3:0]   count;
    localparam SEC5 = 4'd5,
               SEC1 = 4'd1;
    
    always @(posedge clk or posedge rst)
        if (rst == 1) begin // reset handing
            state <= S0;
            count <= 0;
        end else
            case (state) 
                S0: if (count < SEC5) begin // State 0, if less than 5 sec, otherwise go next state
                        state<= S0;
                        count <= count + 1;
                    end else begin
                        state <= S1;
                        count <= 0;
                    end
                S1: if (count < SEC1) begin // state 1, if less than 1 sec, otherwise go to next state
                        state <= S1;
                        count <= count + 1;
                    end else begin
                        state <= S2;
                        count <= 0;
                    end
                S2: if (count < SEC1) begin // state 2, if less than 1 sec, otherwise go to next state
                        state <= S2;
                        count <= count + 1;
                    end else begin
                        state <= S3;
                        count <= 0;
                    end
                    
                S3: if (count < SEC5) begin // state 3, if less than 5 sec, otherwise go to next state
                        state <= S3;
                        count <= count + 1;
                    end else begin
                        state <= S4;
                        count <= 0;
                    end
                S4: if (count < SEC1) begin // state 4, if less than 1 sec, otherwise go to next state
                        state <= S4;
                        count <= count + 1;
                    end else begin
                        state <= S5;
                        count <= 0;
                    end
                S5: if (count < SEC1) begin // state 5, if less than 1 sec, otherwise go to state 0
                        state <= S5;
                        count <= count + 1;
                    end else begin
                        state <= S0;
                        count <= 0;
                    end
                default state <= S0;
          endcase
          
// handing output now
    always @ (*)       
    begin 
        case (state)  // Green 001, Yellow 010, Red 100
            S0: begin light_A <= 3'b001; light_B <= 3'b100; end 
            S1: begin light_A <= 3'b010; light_B <= 3'b100; end                                        
            S2: begin light_A <= 3'b100; light_B <= 3'b100; end  
            S3: begin light_A <= 3'b100; light_B <= 3'b001; end  
            S4: begin light_A <= 3'b100; light_B <= 3'b010; end
            S5: begin light_A <= 3'b100; light_B <= 3'b100; end
         default begin light_A <= 3'b001; light_B <= 3'b100; end    
         endcase  
      end    
endmodule
