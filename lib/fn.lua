fn = {}

function fn.redraw_clock()
  while true do
    fn.increment_arrow_of_time()
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

function fn.break_splash()
  if not cci.is_spash_break then
    cci.is_spash_break = true
    queue:jump("title")
    fn.set_screen_dirty(true)
  end
end

function fn.exit()
  _menu.set_mode(true)
  norns.script.clear()
end