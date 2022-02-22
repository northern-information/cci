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
  event["duration"] = t.d
  event["action"] = t.a
  self.all[t.n] = event
end

function events:is_valid(name)
  for k, event in pairs(self.all) do
    if event.name == name then
      return true
    end
  end
  return false
end

-- 0 d means dynamic. dynamic events are responsible for popping their own queues.
function events:load_all()
  self:register{n = "northern_information",                             d = 0,  a = function() return end }
  self:register{n = "title_and",                                        d = 30, a = function() return end }
  self:register{n = "applied_sciences_and_phantasms_working_division",  d = 30, a = function() return end }
  self:register{n = "title_proudly_present",                            d = 30, a = function() return end }
  self:register{n = "main_menu",                                        d = 0,  a = function() return end }
  self:register{n = "items",                                            d = 0,  a = function() return end }
end