-- by @tyleretters

graphics = {}

function graphics.init()
  graphics.arrow_of_time = 0
  graphics.png_prefix = "/home/we/dust/code/cci/png/"
  screen.aa(1)
  screen.font_face(1)
  screen.font_size(8)
  screen.line_width(1)
  screen.ping()
end

function graphics:render()
  local q = q.current
  if q.name == "splash" then
    screen.clear()
    screen.display_png(graphics.png_prefix .. "splash-owl.png", 0, 0) 
    screen.update()
    if arrow_of_time > 30 then
      q:pop()
    end
  elseif q.name == "main_menu" then
    screen.clear()
    screen.display_png(graphics.png_prefix .. "splash-cci.png", 0, 0)
    screen.move(128, 64)
    screen.level(1)
    screen.text_right("v" .. version)
    screen.move(64, 48)
    screen.level(15)
    screen.text_center("> NEW GAME <")
    screen.move(64, 56)
    screen.level(1)
    screen.text_center("EXIT")
    screen.update()
  elseif q.name == "items" then
    screen.clear()
    local i = items.all[items.selected]
    if i.png then 
      screen.display_png(graphics.png_prefix .. i.png .. ".png", 0, 0) 
    elseif i.lsystem_id then
      local current_instructions = lsys_controller.get_current_instruction()
      if graphics.last_lsys_loaded == nil or i.lsystem_id ~= graphics.last_lsys_loaded then
        graphics.last_lsys_loaded  = i.lsystem_id
        local start_gen = lsys_instructions[i.lsystem_id].starting_generation
        lsys_controller.change_instructions(i.lsystem_id, start_gen) 
      end
      lsys_renderer.draw_lsys()
    end
    screen.level(15)
    screen.move(0, 56)
    screen.text("BUR: " .. i.burden)
    screen.move(0, 64)
    screen.text("(" .. i.rarity .. "/" .. i.type .. ")")
    -- col 2
    screen.move(50, 5)
    screen.text(i.name)
    screen.rect(50, 7, 78, 1)
    screen.fill()
    -- todo, wordwrap function & scrolling
    -- for now, shield ye eyes
    screen.move(50, 15)
    screen.text(self:trim(string.sub(i.description, 1, 16)))
    screen.move(50, 23)
    screen.text(self:trim(string.sub(i.description, 17, 32)))
    screen.move(50, 31)
    screen.text(self:trim(string.sub(i.description, 33, 48)))
    screen.move(50, 39)
    screen.text(self:trim(string.sub(i.description, 49, 64)))
    screen.update()
  end
end

function graphics:trim(s)
  return s:match"^%s*(.*)"
end