module pn_seq_fsm(
  input clk,
  input reset,
  output reg pn_sequence
);
  
  parameter idle=1'b0,state=1'b1;
  reg [2:0] lfsr;
  reg present_state,next_state;
  
  
  always@(posedge clk)
    begin
      if(reset)
        present_state<=idle;
      else
        present_state<=next_state;
    end
  
  always@(*)
    begin
      case(present_state)
        idle:next_state=state;
        state:next_state=state;
        default:next_state=idle;
      endcase
    end
  
  always@(posedge clk)
    begin
      if(reset)begin
        lfsr<=3'b111;
        pn_sequence<=0;
      end
      else
       begin
          case(next_state)
            idle:begin
              lfsr<=3'b111;
              pn_sequence<=lfsr[0];
            end
            state:begin
              lfsr<={lfsr[2]^lfsr[0],lfsr[2:1]};
              pn_sequence<=lfsr[0];
            end
            default:begin
              lfsr<=3'b111;
              pn_sequence<=lfsr[0];
            end
          endcase
        end
    end
            
            
endmodule
