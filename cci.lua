-- CORAL CARRIER INCARNADINE
-- https://cci.dev

version = "0.0.7"

tabutil = require "tabutil"
fn = {}
include "cci/lib/credits"
include "cci/lib/events"
include "cci/lib/filesystem"
include "cci/lib/graphics"
include "cci/lib/hid_controller"
include "cci/lib/items"
include "cci/lib/lsys/includes"
include "cci/lib/norns_controller"
include "cci/lib/script"
include "cci/lib/queue"
include "cci/lib/View"
include "cci/lib/views/Title"

function init()
  filesystem.init()
  hid_controller.init()
  norns_controller.init()
  graphics.init()
  events.init()
  queue.init()
  items.init()
  credits.init()
  lsys_controller:init()
  cci = {}
  local handle = io.popen("cd /home/we/dust/code/cci && git rev-parse --short HEAD")
  cci.hash = string.gsub(handle:read("*a"), "%s+", "")
  handle:close()
  cci.arrow_of_time = 0
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

function fn.redraw_clock()
  while true do
    fn.increment_arrow_of_time()
    -- if arrow_of_time > q.endframe and not q.hold then
    --   q:pop()
    -- end
    if fn.is_screen_dirty() then
      fn.set_screen_dirty(false)
      redraw()
    end
    clock.sleep(1/15)
  end
end

function fn.get_arrow_of_time()
  return cci.arrow_of_time
end

function fn.increment_arrow_of_time()
  cci.arrow_of_time = cci.arrow_of_time + 1
end


function fn.set_screen_dirty(bool)
  cci.is_screen_dirty = bool
end

function fn.is_screen_dirty()
  return cci.is_screen_dirty
end

function fn.set_animation_done(bool)
  cci.is_animation_done = bool
end


function fn.is_animation_done()
  return cci.is_animation_done
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
  if z == 0 then return end
  if k == 2 then norns_controller:yes() end
  if k == 3 then norns_controller:no() end
  screen_dirty = true
end

function cleanup()
  credits:close()
  clock.cancel(redraw_clock_id)
end
