--was gonna do this but i forgot
cool = {}
local optionsShit = {
  'selfAwareness, false',
  'hitsounds, false',
  'eyesores, false',
  'barColors, true'
}
cool.decode = function(wat)
  local shitter = {}
  if wat == nil then
    wat = optionsShit
  end
  for k,v in pairs(wat) do
    local haha = split(v, ', ')
    shitter[haha[1]] = shitter[2]
  end
  return shitter;
end
local function split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
return cool