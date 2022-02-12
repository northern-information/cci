-- by @tyleretters

hid_controller = {}

function hid_controller.init()
  hid_controller.logging = true
end

function hid_controller:handle_code(code, value)
  if hid_controller.logging then
    print(code, value)
  end
  if value == 0 then return end
  if code == "ENTER" then
    q:pop()
  end
  if code == "DOWN" then
    print("left off here")
  end
  if code == "UP" then
    print("left off here")
  end
  if code == "RIGHT" then
    items:next()
    screen_dirty = true
  end
  if code == "LEFT" then
    items:previous()
    screen_dirty = true
  end
  if code == "ESC" then
    _menu.set_mode(true)
    norns.script.clear()
  end
end

function hid_controller:handle_char(ch)
  if hid.controller.logging then
    print(ch)
  end
end