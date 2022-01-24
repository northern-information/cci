items = {}

function items.init()
  items.selected = 1
  items.all = {}
  items:load_all()
end

function items:next()
  self.selected = util.wrap(self.selected + 1, 1, #self.all)
end

function items:previous()
  self.selected = util.wrap(self.selected - 1, 1, #self.all)
end

function items:register(t)
  local item = {}
  item["name"] = t.n
  item["lsystem_name"] = t.n
  item["lsystem_id"] = t.l
  item["png"] = t.p
  item["rarity"] = t.r
  item["burden"] = t.b
  item["description"] = t.d
  item["type"] = t.t
  self.all[#self.all + 1] = item
end

function items:load_all()
  self:register{n = "Staghorn Coral",        l = 1,  p = nil,                       r = "M", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Brain Coral",           l = 2,  p = nil,                       r = "M", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Ceph",                  l = nil,          p = "ceph",                   r = "M", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Floater",               l = nil,          p = "floater",                r = "C", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Glass Eye",             l = nil,          p = "glass-eye",              r = "R", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Gold Bell (750g)",      l = nil,          p = "none",                   r = "M", t = "C",  b = 13,       d = "Shrouded in an enthralling glow, you’re not sure what will happen when you ring it."}
  self:register{n = "Ideonella sakaiensis",  l = nil,          p = "ideonella-sakaiensis",   r = "U", t = "C",  b = 0.1,      d = "Tank containing an infusion of plastic digesting microbes."}
  self:register{n = "Lunar Cap",             l = nil,          p = "lunar-cap",              r = "U", t = "C",  b = 0.1,      d = "Grown on the moon. Restores macrophage."}
  self:register{n = "Microatoll (1m)",       l = nil,          p = "microatoll",             r = "R", t = "C",  b = 1.0,      d = "A robust, one meter toroid of biodiverse coral."}
  self:register{n = "Psilocybin",            l = nil,          p = "psilocybin",             r = "R", t = "C",  b = 0.00015,  d = "100 doses. "}
  self:register{n = "Rebreather",            l = nil,          p = "rebreather",             r = "C", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Slime Mould Alpha",     l = nil,          p = "slime-mould-alpha",      r = "M", t = "C",  b = 0.1,      d = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{n = "Slime Mould Beta",      l = nil,          p = "slime-mould-beta",       r = "M", t = "C",  b = 0.1,      d = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{n = "Slime Mould Delta",     l = nil,          p = "slime-mould-delta",      r = "M", t = "C",  b = 0.1,      d = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{n = "Submarine Eruption",    l = nil,          p = "submarine-eruption",     r = "R", t = "C",  b = 0,        d = "No description."}
  self:register{n = "Waterproof Map (10g)",  l = nil,          p = "none",                   r = "U", t = "C",  b = 1,        d = "The maps seems to depict constellations, but they don’t look similar to anything you've seen in the sky. Perhaps they're mycelial."}
  self:register{n = "Whale Soul",            l = nil,          p = "whale-soul",             r = "M", t = "C",  b = 0,        d = "Aetheric whale consciousness."}
end