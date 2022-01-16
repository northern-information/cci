gfx = {}

function gfx.init()
  gfx.png_prefix = "/home/we/dust/code/coral_carrier_incarnadine/png/"
  screen.aa(1)
  screen.font_face(1)
  screen.font_size(8)
  screen.line_width(1)
end

function gfx:render()
  screen.clear()
  local i = items.all[items.selected]
  -- col 1
  screen.display_png(gfx.png_prefix .. i.png .. ".png", 0, 0)
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