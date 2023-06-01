module predictor (
  input wire request, // Request signal
  input clk, // Clock signal
  input taken, // Taken signal
  output reg prediction, // Prediction signal
  output reg result // Result signal (for testing)
);

  parameter TAKEN = 2'b11; // Strongly taken state
  parameter NOT_TAKEN = 2'b00; // Strongly not taken state
  parameter WEAKLY_TAKEN = 2'b10; // Weakly taken state
  parameter WEAKLY_NOT_TAKEN = 2'b01; // Weakly not taken state

  reg [1:0] state; // State of the predictor

  // Initialize the state to weakly not taken
  initial begin
    state = WEAKLY_NOT_TAKEN;
    result = 0;
  end

  always @(posedge clk) begin
    if (request) begin
      case (state)
        WEAKLY_NOT_TAKEN: begin
          if (taken) begin
            state <= WEAKLY_TAKEN;
          end else begin
            state <= WEAKLY_NOT_TAKEN;
          end
        end
        WEAKLY_TAKEN: begin
          if (taken) begin
            state <= TAKEN;
         end else begin
            state <= WEAKLY_NOT_TAKEN;
          end
        end
        TAKEN: begin
          if (!taken) begin
            state <= WEAKLY_TAKEN;
          end else begin
            state <= TAKEN;
          end
        end
        default: begin // WEAKLY_NOT_TAKEN
          state <= WEAKLY_NOT_TAKEN;
        end
      endcase
    end
  end

  // Output the prediction based on the current state
  always @(state or taken) begin
    case (state)
      WEAKLY_NOT_TAKEN: begin
        prediction = 0;
      end
      WEAKLY_TAKEN: begin
        prediction = taken;
      end
      TAKEN: begin
        prediction = 1;
      end
      default: begin // WEAKLY_NOT_TAKEN
        prediction = 0;
      end
    endcase
  end

endmodule
