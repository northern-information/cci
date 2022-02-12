-- by @tyleretters
-- game events registry

events = {}

function events.init()
  events.all = {}
  events:load_all()
end

function events:register(t)
  local event = {}
  event["name"] = t.n
  event["action"] = t.a
  event["duration"] = t.d
  self.all[t.n] = event
end

function events:load_all()
  self:register{n = "splash",    a = function() print("splash event") end,    d = 30 }
  self:register{n = "main_menu", a = function() print("main menu event") end, d = 0 }
  self:register{n = "items",     a = function() print("items event") end,     d = 0 }
end