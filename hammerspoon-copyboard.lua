-- The file to search. Relative to home directory.
local location = "lalamo.txt"
-- Modifiers necessary to trigger the prompt.
local modifier = {"cmd", "ctrl"}
-- The key after the modifiers nescessary to trigger the prompt.
local key = "p"
-- The separator used to split entries in the location.
local entry_separator = "%%%"
-- The duration of the "Copied!" alert. Set to a 0 to disable.
local copy_alert_duration = 0.5

_G.hs = _G.hs or {}

---@diagnostic disable: cast-local-type
local _split = function(text, pattern, plain)
  local splitStart, length = 1, #text
  return function ()
    if splitStart then
      local sepStart, sepEnd = string.find(text, pattern, splitStart, plain)
      local ret
      if not sepStart then
        ret = string.sub(text, splitStart)
        splitStart = nil
      elseif sepEnd < sepStart then
        ret = string.sub(text, splitStart, sepStart)
        if sepStart < length then
          splitStart = sepStart + 1
        else
          splitStart = nil
        end
      else
        ret = sepStart > splitStart and string.sub(text, splitStart, sepStart - 1) or ''
        splitStart = sepEnd + 1
      end
      return ret
    end
  end
end

local split = function(text, pattern, plain)
  local ret = {}
  for match in _split(text, pattern, plain) do
    table.insert(ret, match)
  end
  return ret
end

local trim = function(string)
  return string:match("^%s*(.-)%s*$")
end

local read = function(path)
  local file = io.open(path, "r")
  if not file then return nil end
  local content = file:read("*all")
  file:close()
  return content
end

local search = function()
  local content = read(os.getenv("HOME") .. "/" .. location)

  if not content then
    hs.alert.show("Could not read ~/" .. location)
    return
  end

  local entries = split(content, entry_separator, true)

  if #entries == 0 then
    hs.alert.show("~/" .. location .. " is empty")
    return
  end

  local chooser = hs.chooser.new(function(choice)
    if choice then
      hs.pasteboard.setContents(choice.text)
      if copy_alert_duration ~= 0 then
        hs.alert.show("Copied!", {}, hs.screen.mainScreen(), copy_alert_duration)
      end
    end
  end)

  local choices = {}

  for i, entry in ipairs(entries) do
    table.insert(choices, {
      id = i,
      text = trim(entry),
    })
  end

  chooser:choices(choices)
  chooser:show()
end

hs.hotkey.bind(modifier, key, search)
