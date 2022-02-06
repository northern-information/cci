-- CORAL CARRIER INCARNADINE
-- https://cci.dev
--
-- language keyboard required

version = "0.0.4"

tabutil = require "tabutil"
include "cci/lib/filesystem"
include "cci/lib/hid_controller"
include "cci/lib/gfx"
include "cci/lib/events"
include "cci/lib/q"
include "cci/lib/items"
include "cci/lib/credits"
include "cci/lib/lsys/includes"

function init()
  filesystem.init()
  hid_controller.init()
  gfx.init()
  events.init()
  q.init()
  items.init()
  credits.init()
  lsys_controller:init()
  arrow_of_time = 0
  q:push("items")
  q:push("main_menu")
  q:push("splash")
  q:pop()
  redraw_clock_id = clock.run(redraw_clock)
end

function redraw()
  gfx:render()
end

function keyboard.code(code, value)
  hid_controller:handle_code(code, value)
end

function keyboard.char(ch)
  hid_controller:handle_char(ch)
end

function enc(e, d)
  print(e, d)
end

function key(k, z)
  print(k, z)
end

function redraw_clock()
  while true do
    clock.sync(1/15)
    arrow_of_time = arrow_of_time + 1
    if arrow_of_time > q.endframe and not q.hold then
      q:pop()
    end
    if screen_dirty then
      redraw()
      screen_dirty = false
    end
  end
end

function cleanup()
  clock.cancel(redraw_clock_id)
end