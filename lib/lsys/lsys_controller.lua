-- by @jaseknighter

-- l-system execution and sound output

------------------------------
-- includes (found in includes.lua) and todo list
--
-- includes: 
--  garden = include("flora/lib/garden/garden.lua")
--  l_system = include("flora/lib/l_system")
--  turtle_class = include("flora/lib/turtle")
--  matrix_stack = include("flora/lib/matrix_stack")
--  rule = include("flora/lib/rule")
------------------------------

local lsys_controller = {}
lsys_controller.__index = lsys_controller

local lsc = {}

function lsc:init(p_id, starting_instruction)
  lsc.index = 1
  lsc.id = p_id and p_id or 1   
  lsc.note_position = vector:new(-10,-10)
  lsc.show_note = false
  lsc.offset = vector:new(0,0)
  lsc.turtle = {}
  lsc.instr = lsys_instructions
  
  lsc.current_instruction = starting_instruction and starting_instruction or 1
  lsc.changing_instructions = false
  lsc.current_sentence_id = 0
  lsc.initializing = true
  -- lsc.play_turtle = true
  lsc.sentence_cursor_index = 1
  lsc.selected_letter = nil
  lsc.restart_rendering = false
  screen.line_width(1)
  lsc.current_generation = 0
  lsc.ruleset = {}
  lsc.initial_turtle_rotation = 90

  lsc.lsys = l_system:new(lsc.axiom,lsc.ruleset)
  lsc.lsys.reset_random_angles()
end
  


lsc.update_ruleset = function(ruleset_id, predecessor, successor)
  lsc.lsys.set_ruleset(ruleset_id, predecessor, successor)
  lsc.changing_instructions = true
end

lsc.update_axiom = function(new_axiom)
  lsc.instr[lsc.get_current_instruction()].axiom = new_axiom
  lsc.lsys.set_axiom(new_axiom) 
end

lsc.get_sentence = function()
  local sentence = lsc.lsys.get_sentence()
  return sentence
end

lsc.set_sentence = function(new_sentence)
  lsc.sentence = lsc.lsys.set_sentence(new_sentence)
  lsc.turtle.set_todo(lsc.sentence)
end

lsc.set_current_page = function(idx)
  lsc.index = idx  
end

lsc.set_active = function(active)
  lsc.active = active == true and true or false
  set_midi_channels()
end

lsc.get_active = function()
  return lsc.active
end

lsc.reset_offset = function()
  lsc.offset = (vector:new(0,0))  
end

lsc.get_offset = function()
  return lsc.offset
end

lsc.set_offset = function(x,y)
  lsc.offset:add(vector:new(x,y))  
end

lsc.get_turtle_positions = function()
  return lsc.turtle.get_positions()
end

lsc.set_angle = function(angle_delta, set_from_param)
  lsc.instr[lsc.get_current_instruction()].angle = lsc.instr[lsc.get_current_instruction()].angle + angle_delta
  lsc.turtle.theta = math.rad(lsc.instr[lsc.get_current_instruction()].angle)
end

lsc.get_angle = function()
  return lsc.instr[lsc.get_current_instruction()].angle
end


local node_length

-- set the node length by given percentage
lsc.set_node_length = function(node_length_pct)
  lsc.turtle.change_length(turtle_min_length, node_length_pct)
end

lsc.get_current_instruction = function()
  return lsc.current_instruction
end

lsc.get_instructions = function(instruction_number)
  if lsc.instr[instruction_number] then
    return lsc.instr[instruction_number]
  else 
    print("cant find instruction", instruction_number)
  end
end 

lsc.get_num_rulesets = function()
  if lsc.lsys then return lsc.lsys.get_num_rulesets() end
end

lsc.set_num_rulesets = function(incr)
  lsc.lsys.set_num_rulesets(incr)
end

lsc.get_predecessor = function(ruleset_id)
  return lsc.lsys.get_predecessor(ruleset_id)
end

lsc.get_successor = function(ruleset_id)
  return lsc.lsys.get_successor(ruleset_id)
end

lsc.get_axiom = function()
  return lsc.lsys.get_axiom()
end

lsc.get_max_generations = function()
  return lsc.max_generations
end

lsc.set_max_generations = function(incr)
  if lsc.max_generations + incr > 0 and lsc.max_generations + incr >= lsc.current_generation then
    lsc.max_generations = lsc.max_generations + incr
    lsc.instr[lsc.get_current_instruction()].max_generations = lsc.max_generations
  end
end

lsc.get_init_length = function()
  return lsc.instr[lsc.get_current_instruction()].length
  -- return lsc.length
end

lsc.set_init_length = function(incr)
  local new_val = lsc.instr[lsc.get_current_instruction()].length + incr
  if new_val > 0 then
    lsc.instr[lsc.get_current_instruction()].length = new_val
  end
end


lsc.get_starting_gen = function(incr)
  return lsc.starting_generation
end

lsc.set_starting_gen = function(incr)
  local new_val = lsc.instr[lsc.get_current_instruction()].starting_generation + incr
  if new_val > 0 and new_val <= lsc.instr[lsc.get_current_instruction()].max_generations then
    lsc.instr[lsc.get_current_instruction()].starting_generation = new_val      
    lsc.starting_generation = new_val
  end
end


lsc.get_init_angle = function()
  -- lsc.initial_turtle_rotation = lsc.instr[instruction_number].initial_turtle_rotation
  return lsc.instr[lsc.get_current_instruction()].initial_turtle_rotation
end

lsc.set_init_angle = function(incr)
  local new_angle = lsc.instr[lsc.get_current_instruction()].initial_turtle_rotation + incr
  lsc.instr[lsc.get_current_instruction()].initial_turtle_rotation = new_angle
end

lsc.get_start_from_x = function()
  return lsc.start_from.x
end

lsc.set_start_from_x = function(incr)
  lsc.instr[lsc.get_current_instruction()].start_from.x = lsc.instr[lsc.get_current_instruction()].start_from.x + incr
end

lsc.get_start_from_y = function()
  return lsc.start_from.y
end

lsc.set_start_from_y = function(incr)
  lsc.instr[lsc.get_current_instruction()].start_from.y = lsc.instr[lsc.get_current_instruction()].start_from.y + incr
end

lsc.get_current_generation = function()
  return lsc.current_generation
end

lsc.setup = function(instruction_number, target_generation)
  initializing = true
  lsc.initializing = true
  lsc.current_generation = 0
  lsc.instr[instruction_number] = lsc.get_instructions(instruction_number)
  if lsc.id == 1 then
    lsc.start_from = vector:new(
      lsc.instr[instruction_number].start_from.x - 32, 
      lsc.instr[instruction_number].start_from.y
    )
  else
    lsc.start_from = vector:new(
      lsc.instr[instruction_number].start_from.x + 32, 
      lsc.instr[instruction_number].start_from.y
    )
  end

  lsc.start_from:add(lsc.offset)
  lsc.ruleset = lsc.instr[instruction_number].ruleset
  lsc.axiom = lsc.instr[instruction_number].axiom
  lsc.max_generations = lsc.instr[instruction_number].max_generations
    
  lsc.length = lsc.instr[instruction_number].length

  lsc.initial_turtle_rotation = lsc.instr[instruction_number].initial_turtle_rotation
  target_generation = target_generation and target_generation or lsc.instr[instruction_number].starting_generation
  lsc.starting_generation = target_generation
  if lsc.current_instruction ~= instruction_number then
    lsc.lsys = l_system:new(lsc.axiom,lsc.ruleset)
    lsc.lsys.reset_random_angles()
  else 
    lsc.lsys.update(lsc.axiom,lsc.ruleset)
  end
  lsc.current_instruction = instruction_number
  
  lsc.sentence = lsc.get_sentence()
  lsc.turtle = turtle_class:new(
    lsc.sentence, 
    lsc.length or 35, 
    math.rad(lsc.instr[instruction_number].angle or 0)
  )
  
  if (target_generation) then
    for i=1, target_generation, 1
      do
        lsc.generate(target_generation)
    end
  end
  
  lsc.initializing = false
  initializing = false
end    

lsc.generate = function(dir)
  local direction
  if (dir == -1 or dir == 1) then
    direction = dir 
  else 
    direction = 1
  end
  
  if (lsc.current_generation >= 0 and lsc.current_generation < lsc.max_generations) then
    lsc.turtle.push()
    local previous_sentence = lsc.get_sentence()
    lsc.turtle.set_previous_todo(previous_sentence)
    lsc.lsys.generate(direction,lsc.random_angles)
    local new_sentence = lsc.get_sentence()
    lsc.current_generation = lsc.current_generation + direction
    lsc.turtle.set_todo(new_sentence)
    lsc.turtle.pop()
    lsc.restart_rendering = true
  end
end
  
lsc.reset_instructions = function()
  lsc.sentence_cursor_index = 1
  if (lsc.initializing == false and lsc.changing_instructions == false) then
    lsc.changing_instructions = true
    lsc.change_instructions(1)  
    lsc.reset_offset()
  end
end 

lsc.set_instructions = function(rotate_by, increment_generation_by)
  local increment_generation_by = increment_generation_by and increment_generation_by or 0
  lsc.sentence_cursor_index = 1
  local num_instructions = garden.get_num_lsys()
  local next_instruction = lsc.current_instruction + rotate_by
  local next_generation = lsc.current_generation + increment_generation_by
  if (next_generation > 0 and 
    next_generation <= lsc.max_generations and 
    next_instruction > 0 and 
    next_instruction <= num_instructions) then
    if (lsc.initializing == false and lsc.changing_instructions == false) then
      lsc.changing_instructions = true
      local target_generation = increment_generation_by ~= 0 and lsc.current_generation + increment_generation_by or 0
      target_generation = target_generation > 0 and target_generation or nil
      lsc.change_instructions(next_instruction, target_generation)  
      lsc.reset_offset()
    end
  end
end 

lsc.change_instructions = function(next_instruction, target_generation)
  lsc.setup(next_instruction, target_generation)
end

lsc.get_plant_info = function()
  local plant_info = ("i".. lsc.current_instruction ..
        " g" .. lsc.current_generation ..
        "/" .. lsc.instr[lsc.get_current_instruction()].max_generations ..
        " a".. math.ceil(math.deg(lsc.turtle.theta)) .. "°(" .. round_decimals(lsc.turtle.theta,3,"up") .. "r)")
  return plant_info
end

lsc.clip_offset = 0

lsc.redraw = function ()
  lsc.turtle.rotate(0, true)
  lsc.turtle.translate(lsc.start_from.x + lsc.offset.x, lsc.start_from.y + lsc.offset.y)
  lsc.turtle.rotate(math.rad(lsc.initial_turtle_rotation))
  lsc.turtle_data = lsc.turtle.render(true)
  screen.update()
  if (lsc.turtle_data) then
    render_percentage_completed = lsc.turtle_data.render_percentage_completed
  end
end

return lsc
