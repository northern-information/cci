local lsys_instructions = {
  -- staghorn coral, from: https://samuelllsvensson.github.io/files/Procedurella_projekt.pdf,
  {
    name = "staghorn",
    start_from = vector:new(45, 30),
    ruleset = {
      {"A","[TF!A[+AF[FB][FB]]]"},
      {"B","[!FB][!FB]"}
      -- {"A","[TF!A[+AF[FB][FFB][FFFB]]]"},
      -- {"B","[!FFFB][!FFFB]"}
    },
    axiom = "F[!A][!A]",
    max_generations = 4,
    length = 5,
    angle = 25,
    starting_generation = 4,
    initial_turtle_rotation = 90
  }
}

return lsys_instructions
