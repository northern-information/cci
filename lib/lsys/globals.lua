-- by @jaseknighter

-- global functions and variables 

-------------------------------------------
-- global functions
-------------------------------------------


round_decimals = function (value_to_round, num_decimals, rounding_direction)
  local rounded_val
  local mult = 10^num_decimals
  if rounding_direction == "up" then
    rounded_val = math.floor(value_to_round * mult + 0.5) / mult
  else
    rounded_val = math.floor(value_to_round * mult + 0.5) / mult
  end
  return rounded_val
end

-------------------------------------------
-- global variables
-------------------------------------------

lsys = {}
initializing = true
RANDOM_ANGLE_MAX = 90
turtle_min_length = 2
MAX_SENTENCE_LENGTH = 1000

