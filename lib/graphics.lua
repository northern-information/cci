-- by @tyleretters

graphics = {}

function graphics.init()
  screen.aa(0)
  screen.font_face(1)
  screen.font_size(8)
  screen.line_width(1)
  screen.ping()
  graphics.png_prefix = cci.absolute_path .. "/png/"
  graphics.arrow_of_time = 0
  graphics.duration_counter = 0
  graphics.is_dynamic_duration = true
  -- title_northern_information
  graphics.title_northern_information_splash_lines_open = {}
  graphics.title_northern_information_splash_lines_close = {}
  graphics.title_northern_information_splash_lines_close_available = {}
  for i=1, 45 do graphics.title_northern_information_splash_lines_open[i] = i end
  for i=1, 64 do graphics.title_northern_information_splash_lines_close_available[i] = i end
end

-- todo: refactor to use the ni graphic lib
function graphics:sift()
  screen.aa(1)
  local percentage = (uref.scroll * -1) / uref.scroll_max
  local scroll_y = (percentage * 64) + 1
  local end_y = uref.scroll_max + (uref.padding * 2)
  -- scrollbar
  if scroll_y < (uref.scroll + end_y) then
    screen.level(4)
    screen.rect(127, scroll_y, 1, 3)
    screen.fill()
  end
  -- filename
  screen.level(15)
  screen.rect(0, uref.scroll, 128, uref.line_height + 1)
  screen.fill()
  screen.level(0)
  screen.pixel(0, uref.scroll)
  screen.pixel(127, uref.scroll)
  screen.move(2, (uref.line_height + uref.scroll) - 2)
  screen.text(uref.files[uref.index])
  screen.fill()
  -- contents
  screen.level(15)
  for i, line in ipairs(uref.lines) do
    screen.move(0, (i * uref.line_height) + uref.scroll + uref.padding)
    screen.text(line)
  end
  -- end indicator
  screen.level(15)
  screen.rect(0, uref.scroll + end_y, 128, uref.line_height + 1)
  screen.fill()
  screen.level(0)
  screen.pixel(0, uref.scroll + uref.line_height + end_y)
  screen.pixel(127, uref.scroll + uref.line_height + end_y)
  screen.move(2, (uref.line_height + uref.scroll + end_y) - 2)
  screen.fill()
end

function graphics:inventory()
  screen.aa(0)
  self:rect(0, 0, 48, 48, 15)
  self:rect(1, 1, 46, 46, 0)
  local i = items.all[items.selected]
  screen.display_png(graphics.png_prefix .. i.png .. ".png", 2, 2) 
  self:text(0, 56, "BUR: " .. i.burden, 15)
  self:text(0, 64, "(" .. i.rarity .. "/" .. i.type .. ")", 15)
  self:text(50, 5, i.name, 15)
  self:rect(50, 7, 78, 1, 15)
  -- todo, wordwrap function & scrolling
  -- for now, shield ye eyes
  self:text(50, 15, self:trim(string.sub(i.description, 1, 16)))
  self:text(50, 23, self:trim(string.sub(i.description, 17, 32)))
  self:text(50, 31, self:trim(string.sub(i.description, 33, 48)))
  self:text(50, 39, self:trim(string.sub(i.description, 49, 64)))
end

function graphics:loading()
  self:text(0, 8, "ESC", 1)
  self:text_right(128, 64, "NOTHING ON RADAR...", 15)
end

function graphics:render()
  queue.current.render()
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
  self:text_center(64, 32, "AND THE POLYMYTHIC", 15)
  fn.set_screen_dirty(true)
end

function graphics:title_owl()
  self:png(-24, 0,  "splash-owl")
  self:text(84, 16, "APPLIED", 15)
  self:text(84, 24, "SCIENCES &", 15)
  self:text(84, 32, "PHANTASMS", 15)
  self:text(84, 40, "WORKING", 15)
  self:text(84, 48, "DIVISION", 15)
  fn.set_screen_dirty(true)
end

function graphics:title_proudly_present()
  self:text_center(64, 32, "PROUDLY PRESENT", 15)
  fn.set_screen_dirty(true)
end

function graphics:title()
  screen.aa(0)
  self:png(0, 0, "splash-cci")
  self:draw_lsys(-40, 0, 1, 1)
  self:draw_lsys(50, 0, 1, 1)
  self:text(0, 64, "v" .. cci.version, 1)  
  self:text_right(128, 64, cci.hash, 1)
  local y = 40
  for k, option in pairs(controller.menu) do
    local name, level = "", 1
    if option.id == controller.selected then
      name = "> " .. option.name .. " <"
      level = 15
    else
      name =  option.name
      level = 1
    end
    self:text_center(64, y, name, level)
    y = y + 8
  end
end

function graphics:draw_lsys(x_offset, y_offset, lsys_scale, level)
  local lsys = lsys_controller:new()
  lsys:init()
  lsys.setup(1, lsys.instr[1].starting_generation, x_offset, y_offset, lsys_scale, level) 
  lsys.redraw()
end

function graphics:title_northern_information()
  local col_x = 34
  local row_x = 34
  local y = 45
  local l = fn.get_arrow_of_time() >= 49 and 0 or 15
  if fn.get_arrow_of_time() >= 49 then
    self:rect(0, 0, 128, 50, 15)
  end

  self:ni(col_x, row_x, y, l)

  if #self.title_northern_information_splash_lines_open > 1 then 
    local delete = math.random(1, #self.title_northern_information_splash_lines_open)
    table.remove(self.title_northern_information_splash_lines_open, delete)
    for i = 1, #self.title_northern_information_splash_lines_open do
      self:mlrs(1, self.title_northern_information_splash_lines_open[i] + 4, 128, 1, 0)
    end
  end

  if fn.get_arrow_of_time() >= 49 then
    self:text_center(64, 60, "NORTHERN INFORMATION, LLC")
  end

  if fn.get_arrow_of_time() > 100 then
    if #self.title_northern_information_splash_lines_close_available > 0 then 
      local add = math.random(1, #self.title_northern_information_splash_lines_close_available)
      table.insert(self.title_northern_information_splash_lines_close, self.title_northern_information_splash_lines_close_available[add])
      table.remove(self.title_northern_information_splash_lines_close_available, add)
    end
    for i = 1, #self.title_northern_information_splash_lines_close do
      self:mlrs(1, self.title_northern_information_splash_lines_close[i], 128, 1, 0)
    end
  end

  if #self.title_northern_information_splash_lines_close_available == 0 then
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

function graphics:png(x, y, filename_no_extension)
  screen.display_png(self.png_prefix .. filename_no_extension .. ".png", x, y)
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

function graphics:trim(s)
  return s:match"^%s*(.*)"
end
