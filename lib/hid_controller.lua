-- by @tyleretters

hid_controller = {}

function hid_controller.init()
  hid_controller.logging = true
end

function hid_controller:handle_code(code, value)
  if hid_controller.logging then
    print(code, value)
  end

  -- act on keydown and keyup
  if code == "RIGHTSHIFT" then
    controller:shift(value)
  end
  if code == "LEFTSHIFT" then
    controller:shift(value)
  end

  -- only act on keydown
  if value == 0 then return end
  
  if code == "ENTER" then
    controller:enter()
  end
  if code == "DOWN" then
    controller:down()
  end
  if code == "UP" then
    controller:up()
  end
  if code == "RIGHT" then
    controller:right()
  end
  if code == "LEFT" then
    controller:left()
  end
  if code == "ESC" then
    controller:esc()
  end
end