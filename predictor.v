module predictor(
   input wire request,      // Request to make prediction   
   input wire clk,          // Clock signal
   input wire taken,        // Feedback if previous branch was taken  
   input wire result,
   output reg prediction    // Output prediction
);

   reg [1:0] counter = 2'b11;  // 2-bit Up/Down counter
      
   always @(posedge clk) begin
      if (result) begin    
         if (taken) begin
            if (counter < 2'd3)    
               counter <= counter + 1'b1; 
         end
         else begin   
            if (counter > 2'd0)
               counter <= counter - 1'b1;             
         end 
         
         // Prediction based on MSB of counter           
                    
      end   
      if (request)
         prediction <= counter[1];
   end
               
endmodule
