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
  self.menu[t.id].change = t.change
end

function controller:clear_menu()
  self.menu = {}
  fn.set_screen_dirty(true)
end

function controller:change()
  self.menu[self.selected].change()
end

function controller:select(i)
  self.selected = i
  self:change()
  fn.set_screen_dirty(true)
end

function controller:enter()
  foley:play("ui-yes")
  self.menu[self.selected].action()
  fn.set_screen_dirty(true)
end

function controller:down()
  foley:play("ui-down")
  self.selected = util.wrap(self.selected + 1, 1, #self.menu)
  self:change()
  fn.set_screen_dirty(true)
end

function controller:up()
  foley:play("ui-up")
  self.selected = util.wrap(self.selected - 1, 1, #self.menu)
  self:change()
  fn.set_screen_dirty(true)
end

function controller:right()
  -- temporary
  foley:play("ui-up")
  items:next()
  fn.set_screen_dirty(true)
end

function controller:left()
  -- temporary
  foley:play("ui-down")
  items:previous()
  fn.set_screen_dirty(true)
end

function controller:esc()
  foley:play("ui-no")
  queue:clear()
  queue:jump("title")
  self:select(1)
  fn.set_screen_dirty(true)
end
