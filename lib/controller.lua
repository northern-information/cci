-- by @tyleretters

controller = {}

function controller.init()
  controller.menu = {}
  controller.selected = 1
end

function controller:add_menu_item(t)
  self.menu[t.id] = {}
  self.menu[t.id].id = t.id
  self.menu[t.id].name = t.name
  self.menu[t.id].action = t.action
end

function controller:clear_menu()
  self.menu = {}
  fn.set_screen_dirty(true)
end

function controller:select(i)
  self.selected = i
  fn.set_screen_dirty(true)
end

function controller:enter()
  self.menu[self.selected].action()
  fn.set_screen_dirty(true)
end

function controller:down()
  self.selected = util.wrap(self.selected - 1, 1, #self.menu)
  fn.set_screen_dirty(true)
end

function controller:up()
  self.selected = util.wrap(self.selected + 1, 1, #self.menu)
  fn.set_screen_dirty(true)
end

function controller:right()
  -- temporary
  items:next()
  fn.set_screen_dirty(true)
end

function controller:left()
  -- temporary
  items:previous()
  fn.set_screen_dirty(true)
end

function controller:esc()
  print("esc")
  fn.set_screen_dirty(true)
end
