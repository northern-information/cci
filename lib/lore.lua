-- by @tyleretters

lore = {}

function lore.init()
  lore.selected = 1
  lore.all = {}
  lore:load_all()
end

function lore:next()
  self.selected = util.wrap(self.selected + 1, 1, #self.all)
end

function lore:previous()
  self.selected = util.wrap(self.selected - 1, 1, #self.all)
end

function lore:register(t)
  local pr = {}
  pr["name"] = t.name
  pr["png"] = t.id
  pr["id"] = t.id
  pr["online"] = t.online
  self.all[#self.all + 1] = pr
end

function lore:load_all()
  self:register{
    name = "Floating Casino",
    id = 'pr-00',
    online = false
  }
  self:register{
    name = "The Palisades",
    id = 'pr-01',
    online = false
  }
  self:register{
    name = "Chembayou",
    id = 'pr-02',
    online = false
  }
  self:register{
    name = "Mannheim",
    id = 'pr-03',
    online = false
  }
  self:register{
    name = "Bay of Guilt",
    id = 'pr-04',
    online = true
  }
  self:register{
    name = "St. Colde",
    id = 'pr-05',
    online = false
  }
  self:register{
    name = "Norns Pirate Radio HQ",
    id = 'pr-06',
    online = true
  }
  self:register{
    name = "Half Hidden Aegal Bloom",
    id = 'pr-07',
    online = false
  }
end