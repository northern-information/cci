-- by @tyleretters

filesystem = {}

function filesystem.init()
  filesystem.pngs = {}
  filesystem:scan_pngs()
end

function filesystem:scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  for filename in pfile:lines() do
    if filename ~= "." and filename ~= ".." then
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end

function filesystem:scan_pngs()
  local scan = util.scandir("/home/we/dust/code/cci/png")
  for k, file in pairs(scan) do
    local name = string.gsub(file, "/", "")
    table.insert(self.pngs, name)
  end
end