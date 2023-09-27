--fixes stuff
fixed = {'singRIGHT', 'singDOWN', 'singUP', 'singLEFT'}
otherShitters = {'tristan-festival', 'bambi-joke', 'bambi-joke-mad', 'bambi-old'}
function goodNoteHit(id, data, type)
  if (stringEndsWith(boyfriendName, '-playable') or stringEndsWith(boyfriendName, '-recursed') and boyfriendName ~= 'bf-recursed') and not getPropertyFromGroup('notes', id, 'noAnimation') and not stringStartsWith(type, 'phone') then
    runHaxeCode([[
      game.boyfriend.playAnim(']]..fixed[data+1]..getPropertyFromGroup('notes', id, 'animSuffix')..[[', true);
      game.boyfriend.holdTimer = 0;
    ]])
  end
end
function opponentNoteHit(id, data, type)
  if stringEndsWith(dadName, '-opponent') and not getPropertyFromGroup('notes', id, 'noAnimation') and not stringStartsWith(type, 'phone') or contains(otherShitters, dadName) then
    runHaxeCode([[
      game.dad.playAnim(']]..fixed[data+1]..getPropertyFromGroup('notes', id, 'animSuffix')..[[', true);
      game.dad.holdTimer = 0;
    ]])
  end
end
function onCreatePost()
  if songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua') then
    initSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
    if save.get('globalGuys') ~= nil then
      if save.get('globalGuys').char ~= nil then
        triggerEvent('Change Character', '', save.get('globalGuys').char)
      end
    end
  end
end
save = {}
function save.get(field, other)
  return getDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, other)
end
function save.set(field, value)
  setDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, value)
end
function contains(tab, what)
  for k,v in pairs(tab) do
    if what == v then
      return true;
    end
  end
  return;
end