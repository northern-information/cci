-- by @tyleretters

script = {}

function script.init()
  script.act = 0
  script.scene = 0
end

function script:action()
  -- this will evolve with scene two
  -- "mvp"
  q:push("items")
  q:push("main_menu")
  q:push("splash")
  q:pop()
end

function script:act(i)
  self.act = i
  return self
end

function script:scene(i)
  self.scene = i
  return self
end