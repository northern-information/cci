-- by @tyleretters
-- game events registry

events = {}

function events.init()
  events.all = {}
  events:load_all()
end

function events:get_by_name(name)
  return self.all[name]
end

function events:register(t)
  local event = {}
  event["name"] = t.name
  event["duration"] = t.duration
  event["render"] = t.render
  event["action"] = t.action
  event["on_arrive"] = t.on_arrive
  event["on_leave"] = t.on_leave
  self.all[t.name] = event
end

function events:is_valid(name)
  for k, event in pairs(self.all) do
    if event.name == name then
      return true
    end
  end
  return false
end

-- 0 duration means dynamic. dynamic events are responsible for popping their own queues.
function events:load_all()

  self:register{
    name = "title",
    duration = 0, 
    on_arrive = function()
      print("arrive title")
      cci.is_spash_break = true
    end,
    on_leave = function()
      print("leaving title")
    end,
    action = function() 
      controller:clear_menu()
      controller:add_menu_item{
        id = 1,
        name = "VIEW ITEMS",
        action = function() queue:jump("view_items") end,
        change = function() print("change") end
      }
      controller:add_menu_item{
        id = 2,
        name = "EXIT",
        action = function() queue:jump("exit") end,
        change = function() print("change") end
      } 
    end,
    render = function()
      graphics:title()
    end
  }

  self:register{name = "title_northern_information",  duration = 0,  action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_northern_information() end }
  self:register{name = "title_and",                   duration = 30, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_and() end }
  self:register{name = "title_owl",                   duration = 50, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_owl() end }
  self:register{name = "title_proudly_present",       duration = 30, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_proudly_present() end }
  self:register{name = "view_items",                  duration = 0,  action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:inventory() return end }
  self:register{name = "exit",                        duration = 0,  action = function() fn.exit() end, change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() return end }

end