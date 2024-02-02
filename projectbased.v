module projectbased(R1,R2,R3,G1,G2,G3,Y1,Y2,Y3,PR,PG,clk,rst);                  
output reg R1,R2,R3,G1,G2,G3,Y1,Y2,Y3,PR,PG;
input clk,rst;
reg [3:0]count;
reg [1:0]state = 2'b0;

always@(posedge clk)
begin
if(~rst)
begin
     R1 = 1'b1; G1 = 1'b0; Y1 = 1'b0;
		R2 = 1'b1; G2 = 1'b0; Y2 = 1'b0;
		R3 = 1'b1; G3 = 1'b0; Y3 = 1'b0;
     state=2'b00;
end
else 
 begin
  case(state)

    2'b00://SIGNAL AT SIGNAL LIGHTS ONE

          begin
			 
           if(count==4'b0101)
            begin
				G1 = 1'b0;
             R1 = 1'b0;
				 Y1 = 1'b1;
				 
            end
           if(count==4'b1001)
            begin
            G1 = 1'b1;
				Y1 = 1'b0; 
				state=2'b01;
            end
            else
            state=2'b00;
           end
          
    2'b01://SIGNAL AT SIGNAL LIGHTS TWO

          begin
          if(count==4'b0101)
           begin
              				Y1 = 1'b1; 
					G1 = 1'b0;
					R2 = 1'b0; 
					Y2 = 1'b1; 
					G2 = 1'b0;
           end
          if(count==4'b1001)
           begin
            R1 = 1'b1; 
					Y1 = 1'b0;
					Y2 = 1'b0; 
					G2 = 1'b1;
					state = 2'b10; 
           end
          else
           state=2'b01;
          end           
 
    2'b10://SIGNAL AT SIGNAL LIGHTS THREE
          begin
          if(count==4'b0101)
           begin
            Y2 = 1'b1; 
					G2 = 1'b0;
					R3 = 1'b0; 
					Y3 = 1'b1; 
					G3 = 1'b0;
           end
          if(count==4'b1001)
           begin
            R2 = 1'b1; 
				Y2 = 1'b0;
				Y3 = 1'b0; 
				G3 = 1'b1;
					state = 2'b11; 
           end
          else
           state=2'b10;
       end
    2'b11://ALL SIGNAL HIGH TO ALLOW PEDESTRIALS TO CROSS
    				begin      
				if(count==4'b0101)
           begin
			  Y1= 1'b0;
            Y3 = 1'b1; 
					G3 = 1'b0;
           end
          if(count==4'b1001)
           begin
			  Y1 =1'b0;
            R3 = 1'b1; 
					Y3 = 1'b0;
					state = 2'b00; 
           end
          else
           state=2'b11;
          end
       endcase
   end
end

always@(count,state)
begin
    if((state==2'b00)&&(count<=4'b1001))
     begin
       PR = 1'b0;
		  PG = 1'b1;
     end
   else
     begin
       PR = 1'b1;
		  PG = 1'b0;
     end
end

//always@(posedge clk_sec)
always@(posedge clk)
begin
	if(rst==1'b0)
      count=4'b0000;
   //else if(clk_sec)
	else if(clk)
     	 	begin
        		if(count[3:0]==4'b1001)
           	count[3:0]=4'b00000000;
				else
           		count[3:0]=count[3:0]+1;
     		end
end

endmodule
