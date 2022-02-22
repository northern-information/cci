-- by @tyleretters

graphics = {}

function graphics.init()
  graphics.arrow_of_time = 0
  graphics.png_prefix = "/home/we/dust/code/cci/png/"
  graphics.splash_lines_open = {}
  graphics.splash_lines_close = {}
  graphics.splash_lines_close_available = {}
  graphics.duration_counter = 0
  graphics.is_dynamic_duration = true
  for i=1,45 do graphics.splash_lines_open[i] = i end
  for i=1,64 do graphics.splash_lines_close_available[i] = i end
  screen.aa(0)
  screen.font_face(1)
  screen.font_size(8)
  screen.line_width(1)
  screen.ping()
end

function graphics:render()
  local c = queue.current.name
      if c == "northern_information"                            then self:northern_information()
  elseif c == "title_and"                                       then self:title_and()
  elseif c == "applied_sciences_and_phantasms_working_division" then self:applied_sciences_and_phantasms_working_division()  
  elseif c == "title_proudly_present"                           then self:title_proudly_present()
  elseif c == "main_menu"                                       then self:main_menu()
  end
  self:decrement_duration_counter()
  if self.duration_counter < 0 and not self.is_dynamic_duration then
    queue:pop()
  end
end

function graphics:is_dynamic_duration()
  return self.is_dynamic_duration
end

function graphics:set_dynamic_duration(bool)
  self.is_dynamic_duration = bool
end

function graphics:decrement_duration_counter()
  self.duration_counter = self.duration_counter - 1
end

function graphics:set_duration_counter(i)
  self.duration_counter = i
end

function graphics:title_and()
  self:text_center(64, 32, "AND", 15)
  fn.set_screen_dirty(true)
end

function graphics:applied_sciences_and_phantasms_working_division()
  self:png(-24, 0, "splash-owl")
  self:text(84, 8,  "THE", 15)
  self:text(84, 16, "APPLIED", 15)
  self:text(84, 24, "SCIENCES", 15)
  self:text(84, 32, "AND", 15)
  self:text(84, 40, "PHANTASMS", 15)
  self:text(84, 48, "WORKING", 15)
  self:text(84, 56, "DIVISION", 15)
  fn.set_screen_dirty(true)
end

function graphics:title_proudly_present()
  self:text_center(64, 32, "PROUDLY PRESENT", 15)
  fn.set_screen_dirty(true)
end

function graphics:main_menu()
  self:png(0, 0, "splash-cci")
  self:text(0, 64, "v" .. version, 1)  
  self:text_right(128, 64, cci.hash, 1)
  self:text_center(64, 40, "> NEW GAME <", 15)
  self:text_center(64, 48, "EXIT", 1)
end

function graphics:png(x, y, filename_no_extension)
  screen.display_png(self.png_prefix .. filename_no_extension .. ".png", x, y)
end

-- function graphics:items()
--   local i = items.all[items.selected]
--   if i.png then 
--     screen.display_png(graphics.png_prefix .. i.png .. ".png", 0, 0) 
--   elseif i.lsystem_id then
--     local current_instructions = lsys_controller.get_current_instruction()
--     if graphics.last_lsys_loaded == nil or i.lsystem_id ~= graphics.last_lsys_loaded then
--       graphics.last_lsys_loaded  = i.lsystem_id
--       local start_gen = lsys_instructions[i.lsystem_id].starting_generation
--       lsys_controller.change_instructions(i.lsystem_id, start_gen) 
--     end
--     lsys_renderer.draw_lsys()
--   end
--   screen.level(15)
--   screen.move(0, 56)
--   screen.text("BUR: " .. i.burden)
--   screen.move(0, 64)
--   screen.text("(" .. i.rarity .. "/" .. i.type .. ")")
--   -- col 2
--   screen.move(50, 5)
--   screen.text(i.name)
--   screen.rect(50, 7, 78, 1)
--   screen.fill()
--   -- todo, wordwrap function & scrolling
--   -- for now, shield ye eyes
--   screen.move(50, 15)
--   screen.text(self:trim(string.sub(i.description, 1, 16)))
--   screen.move(50, 23)
--   screen.text(self:trim(string.sub(i.description, 17, 32)))
--   screen.move(50, 31)
--   screen.text(self:trim(string.sub(i.description, 33, 48)))
--   screen.move(50, 39)
--   screen.text(self:trim(string.sub(i.description, 49, 64)))
-- end

-- function graphics:trim(s)
--   return s:match"^%s*(.*)"
-- end



function graphics:northern_information()
  local col_x = 34
  local row_x = 34
  local y = 45
  local l = fn.get_arrow_of_time() >= 49 and 0 or 15
  if fn.get_arrow_of_time() >= 49 then
    self:rect(0, 0, 128, 50, 15)
  end

  self:ni(col_x, row_x, y, l)

  if #self.splash_lines_open > 1 then 
    local delete = math.random(1, #self.splash_lines_open)
    table.remove(self.splash_lines_open, delete)
    for i = 1, #self.splash_lines_open do
      self:mlrs(1, self.splash_lines_open[i] + 4, 128, 1, 0)
    end
  end

  if fn.get_arrow_of_time() >= 49 then
    self:text_center(64, 60, "NORTHERN INFORMATION")
  end

  if fn.get_arrow_of_time() > 100 then
    if #self.splash_lines_close_available > 0 then 
      local add = math.random(1, #self.splash_lines_close_available)
      table.insert(self.splash_lines_close, self.splash_lines_close_available[add])
      table.remove(self.splash_lines_close_available, add)
    end
    for i = 1, #self.splash_lines_close do
      self:mlrs(1, self.splash_lines_close[i], 128, 1, 0)
    end
  end

  if #self.splash_lines_close_available == 0 then
    queue:pop()
  end

  fn.set_screen_dirty(true)

end

function graphics:ni(col_x, row_x, y, l)
  self:n_col(col_x, y, l)
  self:n_col(col_x+20, y, l)
  self:n_col(col_x+40, y, l)
  self:n_row_top(row_x, y, l)
  self:n_row_top(row_x+20, y, l)
  self:n_row_top(row_x+40, y, l)
  self:n_row_bottom(row_x+9, y+37, l)
  self:n_row_bottom(row_x+29, y+37, l)
end

function graphics:n_col(x, y, l)
  self:mls(x, y, x+12, y-40, l)
  self:mls(x+1, y, x+13, y-40, l)
  self:mls(x+2, y, x+14, y-40, l)
  self:mls(x+3, y, x+15, y-40, l)
  self:mls(x+4, y, x+16, y-40, l)
  self:mls(x+5, y, x+17, y-40, l)
end

function graphics:n_row_top(x, y, l)
  self:mls(x+20, y-39, x+28, y-39, l)
  self:mls(x+20, y-38, x+28, y-38, l)
  self:mls(x+19, y-37, x+27, y-37, l)
  self:mls(x+19, y-36, x+27, y-36, l)
end

function graphics:n_row_bottom(x, y, l)
  self:mls(x+21, y-40, x+29, y-40, l)
  self:mls(x+21, y-39, x+29, y-39, l)
  self:mls(x+20, y-38, x+28, y-38, l)
  self:mls(x+20, y-37, x+28, y-37, l)
end

function graphics:mlrs(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line_rel(x2, y2)
  screen.stroke()
end

function graphics:mls(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line(x2, y2)
  screen.stroke()
end

function graphics:rect(x, y, w, h, l)
  screen.level(l or 15)
  screen.rect(x, y, w, h)
  screen.fill()
end

function graphics:circle(x, y, r, l)
  screen.level(l or 15)
  screen.circle(x, y, r)
  screen.fill()
end

function graphics:text(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text(s)
end

function graphics:text_right(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_right(s)
end

function graphics:text_center(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_center(s)
end
