module predictor(
   input wire request,      // Request to make prediction   
   input wire clk,          // Clock signal
   input wire taken,        // Feedback if previous branch was taken  
   output reg prediction    // Output prediction
);

   reg [1:0] counter = 2'd0;  // 2-bit Up/Down counter
      
   always @(posedge clk) begin
      if (request) begin    
         if (taken) begin
            if (counter < 2'd3)    
               counter <= counter + 1'b1; 
            else
               counter <= 2'd3; 
         end
         else begin   
            if (counter > 2'd0)
               counter <= counter - 1'b1;
            else      
               counter <= 2'd0;                
         end 
         
         // Prediction based on MSB of counter           
         prediction <= counter[1];           
      end           
   end
               
endmodule
