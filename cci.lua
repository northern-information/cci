-- ANSI/ISO Keyboard Required
-- HECATOMB Mod Recommended
-- https://cci.dev

version = "0.0.8"

tabutil = require "tabutil"
include "cci/lib/credits"
include "cci/lib/events"
include "cci/lib/filesystem"
include "cci/lib/fn"
include "cci/lib/graphics"
include "cci/lib/hid_controller"
include "cci/lib/items"
include "cci/lib/lsys/includes"
include "cci/lib/script"
include "cci/lib/queue"
include "cci/lib/controller"

cci = {}

function init()
  filesystem.init()
  controller.init()
  hid_controller.init()
  graphics.init()
  events.init()
  queue.init()
  items.init()
  credits.init()
  cci.hash = fn.get_hash()
  cci.arrow_of_time = 0
  cci.is_splash_break = false
  cci.is_screen_dirty = true
  cci.is_animation_done = false
  cci.redraw_clock_id = clock.run(fn.redraw_clock)
  credits:open()
  script:act(0):scene(0):action()
end

function redraw()
  screen.clear()
  graphics:render()
  screen.update()
end

function keyboard.code(code, value)
  hid_controller:handle_code(code, value)
  fn.break_splash()
end

function keyboard.char(ch)
  hid_controller:handle_char(ch)
  fn.break_splash()
end

function enc(e, d)
  fn.break_splash()
end

function key(k, z)
  fn.break_splash()
end

function cleanup()
  credits:close()
  clock.cancel(redraw_clock_id)
end
