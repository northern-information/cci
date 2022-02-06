-- by @tyleretters

gfx = {}

function gfx.init()
  gfx.png_prefix = "/home/we/dust/code/cci/png/"
  screen.aa(1)
  screen.font_face(1)
  screen.font_size(8)
  screen.line_width(1)
end

function gfx:render()
  screen.clear()
  local i = items.all[items.selected]
  if i.png then 
    screen.display_png(gfx.png_prefix .. i.png .. ".png", 0, 0) 
  elseif i.lsystem_id then
    local current_instructions = lsys_controller.get_current_instruction()
    if gfx.last_lsys_loaded == nil or i.lsystem_id ~= gfx.last_lsys_loaded then
      gfx.last_lsys_loaded  = i.lsystem_id
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

function gfx:trim(s)
  return s:match"^%s*(.*)"
end