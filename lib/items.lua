-- by @tyleretters

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
  item["name"] = t.name
  item["lsystem_name"] = t.name
  item["lsystem_id"] = t.lsystem_id
  item["png"] = t.png
  item["rarity"] = t.rarity
  item["burden"] = t.burden
  item["description"] = t.description
  item["type"] = t.type
  self.all[#self.all + 1] = item
end

function items:load_all()
  self:register{name = "Staghorn Coral",        lsystem_id = 1,   rarity = "M", type = "C", burden = 0,       png = nil,                         description = "No description."}
  self:register{name = "Brain Coral",           lsystem_id = 2,   rarity = "M", type = "C", burden = 0,       png = nil,                         description = "No description."}
  self:register{name = "Ceph",                  lsystem_id = nil, rarity = "M", type = "C", burden = 0,       png = "item-ceph",                 description = "No description."}
  self:register{name = "Floater",               lsystem_id = nil, rarity = "C", type = "C", burden = 0,       png = "item-floater",              description = "No description."}
  self:register{name = "Glass Eye",             lsystem_id = nil, rarity = "R", type = "C", burden = 0,       png = "item-glass-eye",            description = "No description."}
  self:register{name = "Gold Bell (750g)",      lsystem_id = nil, rarity = "M", type = "C", burden = 13,      png = "item-none",                 description = "Shrouded in an enthralling glow, you’re not sure what will happen when you ring it."}
  self:register{name = "Ideonella sakaiensis",  lsystem_id = nil, rarity = "U", type = "C", burden = 0.1,     png = "item-ideonella-sakaiensis", description = "Tank containing an infusion of plastic digesting microbes."}
  self:register{name = "Lunar Cap",             lsystem_id = nil, rarity = "U", type = "C", burden = 0.1,     png = "item-lunar-cap",            description = "Grown on the moon. Restores macrophage."}
  self:register{name = "Microatoll (1m)",       lsystem_id = nil, rarity = "R", type = "C", burden = 1.0,     png = "item-microatoll",           description = "A robust, one meter toroid of biodiverse coral."}
  self:register{name = "Psilocybin",            lsystem_id = nil, rarity = "R", type = "C", burden = 0.00015, png = "item-psilocybin",           description = "100 doses."}
  self:register{name = "Rebreather",            lsystem_id = nil, rarity = "C", type = "C", burden = 0,       png = "item-rebreather",           description = "No description."}
  self:register{name = "Slime Mould Alpha",     lsystem_id = nil, rarity = "M", type = "C", burden = 0.1,     png = "item-slime-mould-alpha",    description = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{name = "Slime Mould Beta",      lsystem_id = nil, rarity = "M", type = "C", burden = 0.1,     png = "item-slime-mould-beta",     description = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{name = "Slime Mould Delta",     lsystem_id = nil, rarity = "M", type = "C", burden = 0.1,     png = "item-slime-mould-delta",    description = "Neuro-Mycelial interface, connection logic, pattern synthesis."}
  self:register{name = "Submarine Eruption",    lsystem_id = nil, rarity = "R", type = "C", burden = 0,       png = "item-submarine-eruption",   description = "No description."}
  self:register{name = "Waterproof Map (10g)",  lsystem_id = nil, rarity = "U", type = "C", burden = 1,       png = "item-none",                 description = "The maps seems to depict constellations, but they don’t look similar to anything you've seen in the sky. Perhaps they're mycelial."}
  self:register{name = "Whale Soul",            lsystem_id = nil, rarity = "M", type = "C", burden = 0,       png = "item-whale-soul",           description = "Aetheric whale consciousness."}
end