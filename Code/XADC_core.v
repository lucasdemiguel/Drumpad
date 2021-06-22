`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2015 03:26:51 PM
// Design Name: 
// Module Name: // Project Name: 
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
 

module XADC_core(
   input CLK100MHZ,
   input vauxp2,
   input vauxn2,
   input vauxp3,
   input vauxn3,
   input vauxp10,
   input vauxn10,
   input vauxp11,
   input vauxn11,
   input vp_in,
   input vn_in,
   input [1:0] sw,
   output drdy,
   output reg [15:0] LED,
   output [15:0] data_out
 );
   
   wire enable;  
   wire ready;
   wire [15:0] data;   
   reg [6:0] Address_in;     
  
   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
   xadc_wiz_1  XLXI_7 (.daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
                     .dclk_in(CLK100MHZ), 
                     .den_in(enable), 
                     .di_in(0), 
                     .dwe_in(0), 
                     .busy_out(),                    
                     .vauxp2(vauxp2),
                     .vauxn2(vauxn2),
                     .vauxp3(vauxp3),
                     .vauxn3(vauxn3),
                     .vauxp10(vauxp10),
                     .vauxn10(vauxn10),
                     .vauxp11(vauxp11),
                     .vauxn11(vauxn11),
                     .vn_in(vn_in), 
                     .vp_in(vp_in), 
                     .alarm_out(), 
                     .do_out(data), 
                     .reset_in(0),
                     .eoc_out(enable),
                     .eos_out(),
                     .channel_out(),
                     .drdy_out(ready));
  
      //led visual dmm              
      always @( posedge(CLK100MHZ))
      begin            
        if(ready == 1'b1)
        begin
          case (data[13:10])
            1:  LED <= 16'b11;
            2:  LED <= 16'b111;
            3:  LED <= 16'b1111;
            4:  LED <= 16'b11111;
            5:  LED <= 16'b111111;
            6:  LED <= 16'b1111111; 
            7:  LED <= 16'b11111111;
            8:  LED <= 16'b111111111;
            9:  LED <= 16'b1111111111;
            10: LED <= 16'b11111111111;
            11: LED <= 16'b111111111111;
            12: LED <= 16'b1111111111111;
            13: LED <= 16'b11111111111111;
            14: LED <= 16'b111111111111111;
            15: LED <= 16'b1111111111111111;                        
           default: LED <= 16'b1; 
           endcase
        end 
      end
 
      always @(posedge(CLK100MHZ))
      begin
        case(sw)
        0: Address_in <= 8'h12;
        1: Address_in <= 8'h13;
        2: Address_in <= 8'h1a;
        3: Address_in <= 8'h1b;
        endcase  
      end
   
   assign data_out = data;
   assign drdy = ready;               
endmodule
