-- by @tyleretters

View = {}

function View:new(t)
  local v = setmetatable({}, {
    __index = View
  })
  v.name = t.name
  v.menu = {}
  v.selected = t.selected
  return v
end

function View:add_menu_item(t)
  self.menu[t.id] = {}
  self.menu[t.id].name = t.name
  self.menu[t.id].action = t.action
end

function View:get_name()
  return self.name
end

function View:get_menu()
  return self.menu
end

function View:get_selected()
  return self.selected
end

function View:move_selected()
  print("mOvEd")
end

function View:trigger_selected()
  print("tRigGerEd")
end