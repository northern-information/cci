-- CORAL CARRIER INCARNADINE
-- https://cci.dev
--
-- k2: previous
-- k3: next

v = "0.0.2"

tabutil = require "tabutil"
include "coral_carrier_incarnadine/lib/filesystem"
include "coral_carrier_incarnadine/lib/gfx"
include "coral_carrier_incarnadine/lib/items"
include "coral_carrier_incarnadine/lib/credits"
include "coral_carrier_incarnadine/lib/lsys/includes"

function init()
  filesystem.init()
  gfx.init()
  items.init()
  credits.init()
  lsys_controller:init()
  screen_dirty = true
  redraw_clock_id = clock.run(redraw_clock)
end

function redraw()
  gfx:render()
end

function enc(e, d)
  if e == 1 then
    print(e, d)
  elseif e == 2 then
    print(e, d)
  elseif e == 3 then
    print(e, d)
  end
  screen_dirty = true
end

function key(k, z)
  if z == 0 then return end
  if k == 2 then items:previous() end
  if k == 3 then items:next() end
  screen_dirty = true
end

function redraw_clock()
  while true do
    clock.sync(1/15)
    if screen_dirty then
      redraw()
      screen_dirty = false
    end
  end
end

function cleanup()
  clock.cancel(redraw_clock_id)
end

function r()
  norns.script.load(norns.state.script)
end