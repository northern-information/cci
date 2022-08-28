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
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-yes.wav")
  self.menu[self.selected].action()
  fn.set_screen_dirty(true)
end

function controller:down()
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-down.wav")
  self.selected = util.wrap(self.selected + 1, 1, #self.menu)
  self:change()
  fn.set_screen_dirty(true)
end

function controller:up()
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-up.wav")
  self.selected = util.wrap(self.selected - 1, 1, #self.menu)
  self:change()
  fn.set_screen_dirty(true)
end

function controller:right()
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-up.wav")
  items:next()
  fn.set_screen_dirty(true)
end

function controller:left()
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-down.wav")
  items:previous()
  fn.set_screen_dirty(true)
end

function controller:esc()
  sampler:play_oneshot(cci.absolute_path .. "/wav/ui-no.wav")
  queue:clear()
  queue:jump("title")
  self:select(1)
  fn.set_screen_dirty(true)
end
