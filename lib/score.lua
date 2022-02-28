-- by @tyleretters

score = {}

function score.init()
  params:set("compressor", 1)
  params:set("reverb", 1)
end

function score:loop(file)
  local path = filesystem.wav_path .. "/" .. file .. ".wav"
  local amp = .25
  local amp_lag = 5
  local sample_start = 0
  local sample_end = 1
  local loop = 1
  local rate = 1
  local trig = 1
  engine.play(path, amp, amp_lag, sample_start, sample_end, loop, rate, trig)
end