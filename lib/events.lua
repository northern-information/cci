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
      sampler:linear_fade_in(cci.absolute_path .. "/wav/music-title.wav", 2)
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
        name = "SIFT",
        action = function()
          queue:jump("sift")
        end,
        change = function() return end
      }
      controller:add_menu_item{
        id = 2,
        name = "ITEMS",
        action = function() queue:jump("items") end,
        change = function() return end
      }
      controller:add_menu_item{
        id = 3,
        name = "EXIT",
        action = function() queue:jump("exit") end,
        change = function() return end
      } 
    end,
    render = function()
      graphics:title()
    end
  }

  self:register{name = "loading",                     duration = 20, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:loading() end }
  self:register{name = "title_northern_information",  duration = 0,  action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_northern_information() end }
  self:register{name = "title_and",                   duration = 30, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_and() end }
  self:register{name = "title_owl",                   duration = 50, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_owl() end }
  self:register{name = "title_proudly_present",       duration = 30, action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:title_proudly_present() end }
  self:register{name = "items",                       duration = 0,  action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:inventory() return end }
  self:register{name = "sift",                        duration = 0,  action = function() return end,    change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() graphics:sift() return end }
  self:register{name = "exit",                        duration = 0,  action = function() fn.exit() end, change = function() return end, on_arrive = function() return end, on_leave = function() return end, render = function() return end }

end