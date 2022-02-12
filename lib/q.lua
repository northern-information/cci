-- by @tyleretters
-- queuing LIFO game event stack

q = {}

function q.init()
  q.logging = true
  q.stack = {}
  q.current = {
    name = "init",
    action = function() return end,
    duration = 0
  }
  q.endframe = 0
  q.hold = false
end

function q:push(name)
  if self.logging then
    print("added to stack: " .. name)
  end
  self.stack[#self.stack + 1] = events.all[name]
end

function q:pop()
  if #self.stack > 0 then
    if self.logging then
      print("popping: " .. self.stack[#self.stack].name)
    end
    self.current = self.stack[#self.stack]
    self.endframe = arrow_of_time + self.current.duration
    self.hold = self.current.duration == 0
    self.stack[#self.stack] = nil
    screen_dirty = true
  end
end

function q:list()
  print("q.current")
  tabutil.print(self.current)
  print("q.stack")
  for k, v in pairs(self.stack) do
    print(k)
    tabutil.print(v)
  end
end