-- by @tyleretters

controller = {}

function controller.init()
  controller.menu = {}
  controller.selected = 1
  controller.is_shifted = false
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
  if queue.current.name == "title" then
    sampler:play_oneshot("ui-yes.wav")
    self.menu[self.selected].action()
  end
  if queue.current.name == "sift" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "items" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "mycochain" then
    sampler:play_oneshot("ui-no.wav")
  end
  fn.set_screen_dirty(true)
end

function controller:down()
  if queue.current.name == "title" then
    sampler:play_oneshot("ui-down.wav")
    self.selected = util.wrap(self.selected + 1, 1, #self.menu)
    self:change()
  end
  if queue.current.name == "sift" then
    sampler:play_oneshot("ui-up.wav")
    local distance = controller.is_shifted and 24 or 4
    uref.scroll_page(distance)
  end
  if queue.current.name == "items" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "mycochain" then
    sampler:play_oneshot("ui-no.wav")
  end
  fn.set_screen_dirty(true)
end

function controller:up()
  if queue.current.name == "title" then
    sampler:play_oneshot("ui-up.wav")
    self.selected = util.wrap(self.selected - 1, 1, #self.menu)
    self:change()
  end
  if queue.current.name == "sift" then
    sampler:play_oneshot("ui-up.wav")
    local distance = controller.is_shifted and -24 or -4
    uref.scroll_page(distance)
  end
  if queue.current.name == "items" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "mycochain" then
    sampler:play_oneshot("ui-no.wav")
  end
  fn.set_screen_dirty(true)
end

function controller:right()
  if queue.current.name == "title" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "sift" then
    sampler:play_oneshot("ui-yes.wav")
    uref.page(1)
  end
  if queue.current.name == "items" then
    sampler:play_oneshot("ui-up.wav")
    items:next()
  end
  if queue.current.name == "mycochain" then
    sampler:play_oneshot("ui-up.wav")
    lore:next()
  end
  fn.set_screen_dirty(true)
end

function controller:left()
  if queue.current.name == "title" then
    sampler:play_oneshot("ui-no.wav")
  end
  if queue.current.name == "sift" then
    sampler:play_oneshot("ui-yes.wav")
    uref.page(-1)
  end
  if queue.current.name == "items" then
    sampler:play_oneshot("ui-down.wav")
    items:previous()
  end
  if queue.current.name == "mycochain" then
    sampler:play_oneshot("ui-down.wav")
    lore:previous()
  end
  fn.set_screen_dirty(true)
end

function controller:shift(value)
  if value == 0 then
    controller.is_shifted = false
  else
    controller.is_shifted = true
  end
end

function controller:esc()
  sampler:play_oneshot("ui-no.wav")
  queue:clear()
  queue:jump("title")
  self:select(1)
  fn.set_screen_dirty(true)
end
