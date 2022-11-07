-- by @tyleretters

credits = {}

function credits.init()
  credits.contributors = {
    "argotechnica",
    "branch",
    "Cementimental",
    "casualdecay",
    "desolationjones",
    "Doberman",
    "eigen",
    "Gahlord",
    "Gordey_Chernyy",
    "Helen",
    "infinitedigits",
    "jaseknighter",
    "jatwo",
    "juje",
    "Justmat",
    "license",
    "McNUG",
    "Obakegaku",
    "pleco",
    "radioedit",
    "Syntheist",
    "tehn",
    "Tyler",
    "tyleretters",
    "Ukasz",
    "vehka",
    "wheelersounds"
  }
end

function credits:divider()
  print()
  print("# # # # # # # # # # # # # # # # # # # # # # # # # # # ")
  print()
end

function credits:open()
  self:divider()
  print("NORTHERN INFORMATION")
  print("AND")
  print("THE APPLIED SCIENCES & PHANTASMS WORKING DIVISION")
  print("PROUDLY PRESENT")
  self:divider()
  print("CORAL CARRIER INCARNADINE")
  print("v" .. cci.version .. " " .. cci.hash)
  print()
  print("         o.               O               O     ")
  print("    O   .#@##  O     o   °#@##  O   #OOOO##@   #")
  print("   O.  O@@@@@OO°    O   #@@@@@OO°  @@@@@@@@@OoO°")
  print("  *° *O@*°#@@@o    o° *##*°@@@@*  o*°°°*°#@@@@* ")
  print(" °@  @@*  *@@O    *# °@@°  *@@o  **      *o@@o  ")
  print(" @@  @@o O°°@     @# .@@* #.*#   O      #° o#   ")
  print(" @@  @@o o°       @# .@@* O.           o@ O.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.o.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.O.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.O.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.O.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.O.    ")
  print("@@@  @@o o°      @@# .@@* O.          °@@.O.    ")
  print("@@#  @@° o°      @@# .@@. O.          °@@.O.    ")
  print("@@@  @*  o°      @@# .@°  O.          °@@.O.    ")
  print("@@@#.O   o°      @@@O°o   O.          °@@.O.    ")
  print(" @@@O    o°       @@@o    O.          °@@.O.    ")
  print(" @@@@o   o°    #  @@@@*   O.    #     °@* O.   #")
  print(" .@@@@#° o°   O.  °@@@@#. O.   O.     *#  O   O.")
  print("  *@@@@@o@#ooO*    *@@@@#o@OooO°    oo*  .@OoO° ")
  print("   o@@@@@@@@@O      O@@@@@@@@@o    O@@O°*#@@@o  ")
  print("    Ooo#@@@@#        Ooo#@@@@O    *OO@@@@@@@O   ")
  print("       .#@@#            °#@##    .O  #OOO#@@    ")
  print("         o°               O.     #        O     ")
  self:coda()
  self:divider()
  print("<DEVLOG>")
  print()
end

function credits:close()
  print()
  print("</DEVLOG>")
  self:divider()
  print("CONTRIBUTORS:") print()
  for k, v in pairs(self.contributors) do
    print("- " .. v)
  end
  self:coda()
end

function credits:coda()
  self:divider()
  print("By the time development of this game is complete, most of our coral reefs could be dead.")
  print()
  print("Donate to the Global Coral Reef Alliance today!")
  print()
  print("https://www.globalcoral.org")
  self:divider()
  print("A cleanup failure and bad clock argument will output after this message.")
  print()
  print("Fear not.")
  print()
  print("All systems are ghosts.")
  self:divider()
end
