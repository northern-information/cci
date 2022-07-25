-- ANSI/ISO Keyboard Required
-- HECATOMB Mod Recommended
-- https://cci.dev

version = "0.0.9"
engine.name = "CCI"
tabutil = require "tabutil"
include "cci/lib/controller"
include "cci/lib/credits"
include "cci/lib/events"
include "cci/lib/filesystem"
include "cci/lib/foley"
include "cci/lib/fn"
include "cci/lib/graphics"
include "cci/lib/hid_controller"
include "cci/lib/items"
include "cci/lib/lsys/includes"
include "cci/lib/queue"
include "cci/lib/score"
include "cci/lib/script"

sampler = include "cci/lib/sampler"
-- sampler:linear_fade_in("/home/we/dust/code/cci/wav/music-title.wav", 2)
sampler:test()

cci = {}

function init()
  cci.absolute_path = "/home/we/dust/code/cci"
  cci.arrow_of_time = 0
  cci.is_splash_break = false
  cci.is_screen_dirty = true
  cci.is_animation_done = false
  controller.init()
  credits.init()
  events.init()
  filesystem.init()
  foley.init()
  graphics.init()
  hid_controller.init()
  items.init()
  queue.init()
  score.init()
  script.init()
  cci.hash = fn.get_hash()
  cci.redraw_clock_id = clock.run(fn.redraw_clock)
  credits:open()
  events.all["title"].action()
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