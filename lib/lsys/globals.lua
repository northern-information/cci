-- by @jaseknighter

-- global functions and variables 

-------------------------------------------
-- global functions
-------------------------------------------

-- from: https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value
function shallow_copy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

string_cut = function(str, start, finish)
  return string.sub(str, start, finish)
end

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

-- fpr flora.lua
alt_key_active = false
screen_level_graphics = 16
screen_size = vector:new(127,64)
center = vector:new(screen_size.x/2, screen_size.y/2)
pages = 1 -- WHAT IS THIS FOR?!?!?
num_pages = 5

lsys_screen_level = 3


lsys = {}
initializing = true
RANDOM_ANGLE_MAX = 90
turtle_min_length = 2


-- for l_system.lua
MAX_SENTENCE_LENGTH = 1000

