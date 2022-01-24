local lsys_renderer = {}

function lsys_renderer.check_lsys_position()
  local left_edge = 5 
  local right_edge = 45
  local top_edge = 5
  local bottom_edge = 45
  local leftmost_point, rightmost_point, topmost_point, bottommost_point
  local turtle_positions = lsys_controller.get_turtle_positions()
  for j=1, #turtle_positions,1
    do
      if (leftmost_point == nil and turtle_positions[j].x) then
        leftmost_point = turtle_positions[j].x
        rightmost_point = turtle_positions[j].x
        topmost_point = turtle_positions[j].y
        bottommost_point = turtle_positions[j].y
      end

      if (leftmost_point and turtle_positions[j].x) then
        if (turtle_positions[j].x < leftmost_point) then
          leftmost_point = turtle_positions[j].x
        end
        if (turtle_positions[j].x > rightmost_point) then
          rightmost_point = turtle_positions[j].x
        end
        if (turtle_positions[j].y < topmost_point) then
          topmost_point = turtle_positions[j].y
        end
        if (turtle_positions[j].y > bottommost_point) then
          bottommost_point = turtle_positions[j].y
        end
      end
    end
      
    if (leftmost_point) then

      local plant_width = rightmost_point - leftmost_point
      local plant_height = bottommost_point - topmost_point
      
      if plant_width > 50 or plant_height > 50 then
        lsys_controller.set_node_length(0.8)
        clock.run(lsys_renderer.redraw_lsys)
      end
      if (plant_width < 10 and plant_height < 10) then
        lsys_controller.set_node_length(1.2)
        clock.run(lsys_renderer.redraw_lsys)
      end
      if (leftmost_point < left_edge) then
        lsys_controller.set_offset(2, 0)
        clock.run(lsys_renderer.redraw_lsys)
      end 
      
      if topmost_point < top_edge  then
        lsys_controller.set_offset(0, 2)
        clock.run(lsys_renderer.redraw_lsys)
      end
      
      if rightmost_point > right_edge then
        lsys_controller.set_offset(-2, 0)
        clock.run(lsys_renderer.redraw_lsys)
      end
      if bottommost_point > bottom_edge then
        lsys_controller.set_offset(0, -2)
        clock.run(lsys_renderer.redraw_lsys)
      end
  end
end

lsys_renderer.redraw_lsys = function()
  clock.sync(1/15)
  screen_dirty = true
end      

-- local draw_lsys = function()
--   local lsys_randomized = string.find(lsys.sentence, "r")
--   if lsys_randomized then
--     screen.clear() 
--     screen.level(lsys_screen_level)
--     lsys.redraw()
--   end  
-- end

lsys_renderer.draw_lsys = function()
  lsys_controller.redraw()
  lsys_renderer.check_lsys_position() 

  -- lsys_renderer.draw_lsys()
end

return lsys_renderer
