-- by @tyleretters

foley = {}

function foley.init()
  -- empty
end

function foley:play(file)
  local path = filesystem.wav_path .. "/" .. file .. ".wav"
  local amp = 1
  local amp_lag = 0
  local sample_start = 0
  local sample_end = 1
  local loop = 0
  local rate = 1
  local trig = 1
  engine.play(path, amp, amp_lag, sample_start, sample_end, loop, rate, trig)
end