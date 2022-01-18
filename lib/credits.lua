credits = {}

function credits.init()
  local contributors = {
    "desolationjones",
    "Doberman",
    "eigen",
    "infinitedigits",
    "juje",
    "Justmat",
    "Syntheist",
    "Tyler",
    "tyleretters",
    "Ukasz"
  }
  print("~~~~~~~~~~~~~~~~~~~~~~~~~")
  print("CORAL CARRIER INCARNADINE") print()
  print("CONTRIBUTORS:") print()
  for k, v in pairs(contributors) do
    print("- " .. v)
  end
  print()
  print("~~~~~~~~~~~~~~~~~~~~~~~~~")
end