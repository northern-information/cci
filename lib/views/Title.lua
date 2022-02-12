-- by @tyleretters

Title = View:new{
  name = "Main Menu"
}

Title:add_menu_item{
  id = 1,
  name = "New Game",
  action = function()
    print("start a new game logic here")
  end
}

Title:add_menu_item{
  id = 2,
  name = "Exit",
  action = function()
    _menu.set_mode(true)
    norns.script.clear()
  end
}