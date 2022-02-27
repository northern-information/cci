-- by @tyleretters

filesystem = {}

function filesystem.init()
  filesystem.png_path = cci.absolute_path .. "/png"
  filesystem.pngs = {}
  filesystem:scan_pngs()
  filesystem.wav_path = cci.absolute_path .. "/wav"
  filesystem.wavs = {}
  filesystem:scan_wavs()
end

function filesystem:get_wav_path()
  return self.wav_path
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
  local scan = util.scandir(self.png_path)
  for k, file in pairs(scan) do
    local name = string.gsub(file, "/", "")
    table.insert(self.pngs, name)
  end
end

function filesystem:scan_wavs()
  local scan = util.scandir(self.wav_path)
  for k, file in pairs(scan) do
    local name = string.gsub(file, "/", "")
    table.insert(self.wavs, name)
  end
end