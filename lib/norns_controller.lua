-- by @tyleretters

norns_controller = {}

function norns_controller.init()
  print("hello i am norns controller and i hope to grow up some day.")
end

function norns_controller:yes()
  View:trigger_selected()
end

function norns_controller:no()
  View:move_selected()
end