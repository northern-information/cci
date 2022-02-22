-- by @tyleretters
-- queuing LIFO main event stack

queue = {}

function queue.init()
  queue.logging = true
  queue:clear()
end

function queue:clear()
  queue.stack = {}
  queue.current = {
    name = "init",
    duration = 0,
    action = function() return end,
  }
end

function queue:push(name)
  if events:is_valid(name) then
    if self.logging then
      print("added to stack: " .. name)
    end
    self.stack[#self.stack + 1] = events.all[name]
  else
    print("error: invalid event name " .. name)
  end
end

function queue:jump(name)
  self:clear()
  self:push(name)
  self:pop()
end

function queue:pop()
  -- trigger the on_leave action for the current event
  self.stack[#self.stack].on_leave()
  if #self.stack > 0 then
    if self.logging then
      print("popping: " .. self.stack[#self.stack].name)
    end
    self.current = self.stack[#self.stack]
    if self.current.duration == 0 then
      graphics:set_duration_counter(0)
      graphics:set_dynamic_duration(true)
    else
      graphics:set_duration_counter(self.current.duration)
      graphics:set_dynamic_duration(false)
    end
    self.current.on_arrive()
    self.current.action()
    self.stack[#self.stack] = nil
    fn.set_screen_dirty(true)
  end
end

function queue:list()
  tabutil.print(self.current)
  for k, v in pairs(self.stack) do
    print(k)
    tabutil.print(v)
  end
end