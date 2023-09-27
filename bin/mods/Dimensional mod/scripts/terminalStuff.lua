--add your own stuff here if you want
function onCreate()
  initSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
  addHaxeLibrary('StrumNote')
  addHaxeLibrary('Math')
  modchart = save.get('terminalModChart')
  debugPrint(modchart)
  luaDebugMode = true
  local starterThings = {
    ['dave'] = function()
      callOnLuas('enableCheatingModchart', {})
    end
  }
  if modchart and starterThings[modchart] then
    starterThings[modchart]()
  end
  origSpeed = getProperty('songSpeed')
end
function onCreatePost()
  local starterThings = {
    ['tristan'] = function()
      triggerEvent('Change Character', '1', 'tristan-opponent')
      runHaxeCode[[
        game.vocals = new FlxSound().loadEmbedded(Paths.voices('house-tristan'));
      ]]
      for i=0,3 do
        local swagOrder = {0,3,2,1}
        strum(false, i, _G['defaultOpponentStrumX'..tostring(swagOrder[i+1])])
        strum(true, i, _G['defaultPlayerStrumX'..tostring(swagOrder[i+1])])
      end
    end,
    ['bambi'] = function()
      runHaxeCode[[
        var oldArray = game.keysArray;
        game.keysArray = [ oldArray[2],  oldArray[2],  oldArray[2], oldArray[2] ];
        for(strum in game.strumLineNotes)
        {
          strum.animation.addByPrefix('static', 'arrowUP');
					strum.animation.addByPrefix('pressed', 'up press', 24, false);
					strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
          strum.playAnim('static', true);
        }
        for(note in game.unspawnNotes)
        {
          note.animation.addByPrefix('greenScroll', 'green0');
          note.animation.addByPrefix('greenholdend', 'green hold end');
          note.animation.addByPrefix('greenhold', 'green hold piece');
          note.copyX = false;
          if(note.mustPress)
            note.x = game.playerStrums.members[3].x;
          else
            note.x = game.opponentStrums.members[3].x;
          
          
        }
      ]]
    end
  }
  if modchart and starterThings[modchart] then
    starterThings[modchart]()
  end
end
elapsedTime = 0
function onUpdate(elapsed)
  elapsedTime = elapsedTime + elapsed;
  if modchart and not inGameOver then
    local modcharts = {
      ['dave'] = function()
        for i=0,3 do
          strumAdd(true, i, math.sin(elapsedTime) * ((i % 2 == 0) and 1 or -1))
          strumAdd(true, i, -(math.sin(elapsedTime) * 1.5))
          strumAdd(false, i, -(math.sin(elapsedTime) * ((i % 2 == 0) and 1 or -1)))
          strumAdd(false, i, math.sin(elapsedTime) * 1.5)
        end
      end,
      ['tristan'] = function()
        setProperty('songSpeed', 3 + math.sin(elapsedTime / 5))
      end
    }
    if modcharts[modchart] then
      modcharts[modchart]()
    end
  end
end
function strum(player, member, x, y)
  local strum = player and 'playerStrums' or 'opponentStrums'
  if x then
    setPropertyFromGroup(strum, member, 'x', x)
  end
  if y then
    setPropertyFromGroup(strum, member, 'y', y)
  end
end
function getstrum(player, member)
  local strum = player and 'playerStrums' or 'opponentStrums'
  return {
    x = getPropertyFromGroup(strum, member, 'x'),
    y = getPropertyFromGroup(strum, member, 'y')
  }
end
function strumAdd(player, member, x, y)
  local strum = player and 'playerStrums' or 'opponentStrums'
  if x then
    setPropertyFromGroup(strum, member, 'x', x + getstrum(player, member).x)
  end
  if y then
    setPropertyFromGroup(strum, member, 'y', y + getstrum(player, member).y)
  end
end
save = {}
function save.get(field, other)
  if field == nil then return false end
  return getDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, other)
end
function save.set(field, value)
  setDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, value)
end