-- by @tyleretters

script = {}

function script.init()
  script.a = 0 -- act
  script.s = 0 -- scene
end

function script:action()
  if self.a == 0 and self.s == 0 then
    score:loop("music-title")
    queue:push("title")
    queue:push("title_proudly_present")
    queue:push("title_owl")
    queue:push("title_and")
    queue:push("title_northern_information")
  end
  queue:pop()
end

function script:act(i)
  self.a = i
  return self
end

function script:scene(i)
  self.s = i
  return self
end