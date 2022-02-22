-- by @tyleretters

script = {}

function script.init()
  script.act = 0
  script.scene = 0
end

function script:action()
  if self.act == 0 and self.scene == 0 then
    queue:push("main_menu")
    queue:push("title_proudly_present")
    queue:push("applied_sciences_and_phantasms_working_division")
    queue:push("title_and")
    queue:push("northern_information")
  end
  queue:pop()
end

function script:act(i)
  self.act = i
  return self
end

function script:scene(i)
  self.scene = i
  return self
end