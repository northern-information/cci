-- by @tyleretters

uref = {}

function uref.init()
  uref.root = cci.absolute_path .. "/sift/"
  uref.max_width = 120
  uref.word_wrap_symbol = " "
  uref.files = {}
  uref.lines = {}
  uref.index = 1
  uref.scroll = 0
  uref.scroll_max = 0
  uref.line_height = 8
  uref.padding = 12
  uref.scan_library()
  uref.word_wrap(uref.root .. uref.files[uref.index])
end
    
function uref.scan_library()
  local scan = util.scandir(uref.root)
  for k, file in pairs(scan) do
    local name = string.gsub(file, "/", "")
    uref.files[#uref.files + 1] = name
  end
end
  
function uref.word_wrap(file_absolute_path)
  local file = io.open(file_absolute_path, "rb")
  local file_raw = file:read("*a")
  file:close()
  local file_into_lines = file_raw:gsub("\r\n?", "\n"):gmatch("(.-)\n")
  local line_number = 1
  while true do
    local line = file_into_lines()
    if line == nil then break end
    if screen.text_extents(line) <= uref.max_width then
      -- this line is shorter than the max width
      -- no manipulation needed
      uref.lines[line_number] = line
      line_number = line_number + 1
    else
      -- this line is longer than the max width, so let us figure out where to wrap
      local line_buffer, words, i, ii, is_first_word_of_wrapped_line = "", {}, 1, 1, false
      -- build a table with all the words in this line
      for this_word in line:gmatch("([^%s]+)") do
        words[i] = this_word
        i = i + 1
      end
      while true do
        local current_word = words[ii]
        local next_word = words[ii+1]
        if line_buffer == "" then
          -- always load the first word
          if is_first_word_of_wrapped_line then
            line_buffer =  uref.word_wrap_symbol .. " " .. current_word
            is_first_word_of_wrapped_line = false
          else
            line_buffer = current_word
          end
        end
        if next_word == nil then
          -- the current_word is the final word in the line, so end
          uref.lines[line_number] = line_buffer
          line_number = line_number + 1
          break
        else
          -- lookahead to test the new length
          local test = line_buffer .. " " .. next_word
          if screen.text_extents(uref.word_wrap_symbol .. " " .. test) <= uref.max_width then
            -- test passes (we are less than or equal to the max width) so continue
            line_buffer = test
          else
            -- test fails (we are over the max width) so commit this line and continue
            uref.lines[line_number] = line_buffer
            line_buffer = ""
            is_first_word_of_wrapped_line = true -- setup for the next iteration
            line_number = line_number + 1
          end
        end
        ii = ii + 1
        if ii > #words then break end -- end of this line
      end
    end
  end
  uref.scroll_max = uref.get_scroll_end()
end
    
function uref.page(i)
  if i == -1 then
    uref.index = util.wrap(uref.index - 1, 1, #uref.files)
  else
    uref.index = util.wrap(uref.index + 1, 1, #uref.files)
  end
  uref.lines = {}
  uref.scroll = 0
  word_wrap(uref.root .. uref.files[uref.index])
end

function uref.scroll_page(d)
  uref.scroll = uref.scroll - d
  if uref.scroll > 0 then uref.scroll = 0 end
  local end_check = uref.get_scroll_end() * -1
  if uref.scroll < end_check then uref.scroll = end_check end
  screen_dirty = true
end

function uref.get_scroll_end()
  return (#uref.lines * uref.line_height)
end