`timescale 1ns / 1ps

module clk_prescaler(input clk_in, output reg clk_out); // fin=100MHz, fout = 50 Hz
reg[19:0] counter = 20'd0;
initial clk_out = 0;

always @(posedge clk_in)
begin
if(counter >= 999_999)
begin
counter <= 0;
clk_out <= ~clk_out; 
end 
else
begin
counter <= counter + 1;
end
end
endmodule 
// ---------------------------------------------- //

module counter(input clk, reset, output reg [9:0]out);
initial out  = 0;
always @(posedge clk)
begin
if(reset)
out <= 0;
else 
begin
if(out >= 99) // 50Hz
out <= 0;
else 
out <= out + 1;
end
end
endmodule
// ---------------------------------------------- //

module debouncer(input clk, in, output reg out);

reg [2:0]counter = 3'b000;

always @(posedge clk) 
begin
counter <= {counter[1:0], in};
out <= (counter == 3'b111) ? 1 : 0;
end

//assign out = (counter == 3'b111)? 1 : 0;
endmodule
// ---------------------------------------------- //

module comparator(input [7:0]in1,input [7:0]in2, output wire out);
assign out = (in2 > in1) ? 0 : 1; 
endmodule
// ---------------------------------------------- //

module PWM_duty_btn(input clk, reset, btn_in, output reg[7:0] out);
reg [2:0] shift_reg = 3'b000;
reg btn_last_val = 0;
initial out = 8'b00000000;
initial shift_reg = 3'b000;
initial btn_last_val = 0;

always @(posedge clk) 
begin
if(reset)
out <= 8'b00000000;

else 
begin 
shift_reg <= {shift_reg[1:0], btn_in}; 
if(shift_reg == 3'b111 && !btn_last_val)
begin       
  if(out >= 90)
    out <= 8'b00000000;
  else
    out <= out + 10;
end
btn_last_val <= (shift_reg == 3'b111); 
end
end
endmodule

module PWM_mode_btn(input clk, reset, btn_in, output reg out); //General Purpose button
reg [2:0] shift_reg = 3'b000;
reg btn_last_val = 0;

always @(posedge clk) 
begin
if(reset)
out <= 0;

else 
begin 
shift_reg <= {shift_reg[1:0], btn_in}; 
if(shift_reg == 3'b111 && !btn_last_val)
begin
  out <= !out; 
end
btn_last_val <= (shift_reg == 3'b111); 
end
end
endmodule

module PWM_Controller(input clk, 			  // Low freq. Clk
          input reset,			  
          input[9:0] counter,	  // input counter
          input edge_center_mode, // edge or center aligned mode
          input[7:0] PWM_duty, 	  // 10 -> 10%, 20 ->20%, 30 -> 30% etc.
          input out_polarity,
          output reg out);

reg PWM_signal = 0;
parameter center_modeLow = 48;
parameter center_modeHigh = 49;

always @(posedge clk)
begin
if(reset)
begin
out <= 0;
end

else
begin 
if(edge_center_mode) //edge align mode
begin
  if(counter >= PWM_duty)
    PWM_signal <= 0;
  else
    PWM_signal <= 1; 
end

else if(!edge_center_mode)// centrer align mode
begin
  if((counter > center_modeLow - (PWM_duty/2)) && (counter < center_modeHigh + (PWM_duty/2)))
    PWM_signal <= 1;
  else
    PWM_signal <= 0; 
end

if (out_polarity) 
out <= PWM_signal;
else
out <= ~PWM_signal;
end
end
endmodule


module top(input clk_in, 
reset_btn,
duty_btn,
low_hightrueBtn,
edge_centerModeBtn,
input[3:0]channel_select, 

output PWM0,
PWM1,
PWM2,
PWM3);

wire clk_presc;
wire [9:0] counter;

reg [7:0] PWM_duty[3:0];   wire[7:0] PWM_dutyBtn;    
reg out_polarity[3:0];     wire PWM_polarityBtn;
reg edge_center_mode[3:0]; wire PWM_edgeCenterModeBtn;



clk_prescaler clk_prescaler_t(.clk_in(clk_in), .clk_out(clk_presc));
counter counter_t(.clk(clk_in), .reset(reset_btn), .out(counter));

PWM_duty_btn PWM_duty_btn_t(
.clk(clk_presc),
.reset(reset_btn),
.btn_in(duty_btn),
.out(PWM_dutyBtn));

PWM_mode_btn PWM_mode_btn_t(
.clk(clk_presc),
.reset(reset_btn),
.btn_in(low_hightrueBtn),
.out(PWM_polarityBtn));

PWM_mode_btn PWM_mode_btn_edge(
.clk(clk_presc),
.reset(reset_btn),
.btn_in(edge_centerModeBtn),
.out(PWM_edgeCenterModeBtn));


always @(posedge clk_presc)
    begin
//        case(channel_select)
//            4'b0000:
//            begin
//                PWM_duty[0] <= PWM_dutyBtn; out_polarity[0] <= PWM_polarityBtn; edge_center_mode[0] <= PWM_edgeCenterModeBtn;  
//            end
//            4'b0010: 
//            begin
//                PWM_duty[1] <= PWM_dutyBtn; out_polarity[1] <= PWM_polarityBtn; edge_center_mode[1] <= PWM_edgeCenterModeBtn;
//            end
//            4'b0100: 
//            begin
//                PWM_duty[2] <= PWM_dutyBtn; out_polarity[2] <= PWM_polarityBtn; edge_center_mode[2] <= PWM_edgeCenterModeBtn;
//            end
//            4'b1000: 
//            begin
//                PWM_duty[3] <= PWM_dutyBtn; out_polarity[3] <= PWM_polarityBtn; edge_center_mode[3] <= PWM_edgeCenterModeBtn;
//            end
////            default: begin
////            PWM_duty[0] <= PWM_duty[0];out_polarity[0] <= PWM_polarityBtn; edge_center_mode[0] <= PWM_edgeCenterModeBtn;  
////            PWM_duty[1] <= PWM_duty[1];out_polarity[1] <= PWM_polarityBtn; edge_center_mode[1] <= PWM_edgeCenterModeBtn;
////            PWM_duty[2] <= PWM_duty[2];out_polarity[2] <= PWM_polarityBtn; edge_center_mode[2] <= PWM_edgeCenterModeBtn;
////            PWM_duty[3] <= PWM_duty[3];out_polarity[3] <= PWM_polarityBtn; edge_center_mode[3] <= PWM_edgeCenterModeBtn;
////            end
//        endcase


      if(channel_select == 4'b0000)
        begin
          PWM_duty[0] <= PWM_dutyBtn;
          out_polarity[0] <= PWM_polarityBtn;
          edge_center_mode[0] <= PWM_edgeCenterModeBtn;       
        end

      else if(channel_select == 4'b0010)
        begin
          PWM_duty[1] <= PWM_dutyBtn;
          out_polarity[1] <= PWM_polarityBtn;
          edge_center_mode[1] <= PWM_edgeCenterModeBtn;
        end
      else if(channel_select == 4'b0100)
        begin
          PWM_duty[2] <= PWM_dutyBtn;
          out_polarity[2] <= PWM_polarityBtn;
          edge_center_mode[2] <= PWM_edgeCenterModeBtn;
        end
      else if(channel_select == 4'b1000)
        begin
          PWM_duty[3] <= PWM_dutyBtn;
          out_polarity[3] <= PWM_polarityBtn;
          edge_center_mode[3] <= PWM_edgeCenterModeBtn;
        end

      else
        begin
          PWM_duty[0] <= 0;
          PWM_duty[1] <= 0;
          PWM_duty[2] <= 0;
          PWM_duty[3] <= 0;

          out_polarity[0] <= 0;
          out_polarity[1] <= 0;
          out_polarity[2] <= 0;
          out_polarity[3] <= 0;

          edge_center_mode[0] <= 0;
          edge_center_mode[1] <= 0;
          edge_center_mode[2] <= 0;
          edge_center_mode[3] <= 0;
        end
end


PWM_Controller PWM0_t(.clk(clk_presc), 
            .reset(reset_btn),
            .counter(counter),
            .edge_center_mode(edge_center_mode[0]),
            .PWM_duty(PWM_duty[0]),
            .out_polarity(out_polarity[0]),
            .out(PWM0));

PWM_Controller PWM1_t(.clk(clk_presc),
            .reset(reset_btn), .counter(counter),
            .edge_center_mode(edge_center_mode[1]),
            .PWM_duty(PWM_duty[1]),
            .out_polarity(out_polarity[1]),
            .out(PWM1));

PWM_Controller PWM2_t(.clk(clk_presc),
            .reset(reset_btn), .counter(counter), 
            .edge_center_mode(edge_center_mode[2]),
            .PWM_duty(PWM_duty[2]),
            .out_polarity(out_polarity[2]),
            .out(PWM2));

PWM_Controller PWM3_t(.clk(clk_presc), 
            .reset(reset_btn),
            .counter(counter), 
            .edge_center_mode(edge_center_mode[3]),
            .PWM_duty(PWM_duty[3]),
            .out_polarity(out_polarity[3]),
            .out(PWM3));

endmodule
