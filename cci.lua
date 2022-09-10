-- 0x002: MAIDéNFALL...
-- 0x000: SALVAGé MODé éNABLé
-- 0x032: éncs offline kéys null
-- ANSI/ISO Keyboard Required
-- See: System > Devices > HID
-- HECATOMB Mod Recommended
--
-- https://cci.dev

cci = {}
cci.version = "0.0.10"
engine.name = "CCI"
tabutil = require "tabutil"
params:set("compressor", 1)
params:set("reverb", 1)
include "cci/lib/controller"
include "cci/lib/credits"
include "cci/lib/events"
include "cci/lib/filesystem"
include "cci/lib/fn"
include "cci/lib/graphics"
include "cci/lib/hid_controller"
include "cci/lib/items"
include "cci/lib/lsys/includes"
include "cci/lib/queue"
include "cci/lib/sampler"
include "cci/lib/script"
include "cci/lib/uref"

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
  graphics.init()
  hid_controller.init()
  items.init()
  queue.init()
  script.init()
  uref.init()
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
  print("Encoders not operational.")
  fn.break_splash()
end

function key(k, z)
  if z == 0 then return end
  print("Keys not operational.")
  fn.break_splash()
end

function cleanup()
  credits:close()
  clock.cancel(redraw_clock_id)
end