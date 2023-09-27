--code that brings the player to the title screen song

function onCreatePost()
  initSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
  globalCool = save.get('globalGuys')
  storyModeShit = globalCool.isStoryMode == true
end
save = {}
function save.get(field, other)
  if field == nil then return nil end
  return getDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, other)
end
function save.set(field, value)
  setDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, value)
end
thisissocool = false
function preventEndSong(what)
  thisissocool = what
  --debugPrint('preventEndSong: ',thisissocool)
end
function onEndSong() 
  if songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua') then
    if not thisissocool then --im going to scream
      if not storyModeShit then
        loadSong(dofile('mods/'..currentModDirectory..'/modName.lua'), -1)
      else
        globalCool.songIndex = globalCool.songIndex + 1
        save.set('globalGuys', globalCool)
        if #globalCool.songList < globalCool.songIndex then --finished week yay
          loadSong(dofile('mods/'..currentModDirectory..'/modName.lua'), -1)
        else
          local daSong = globalCool.songList[globalCool.songIndex]
          if daSong:lower() == 'maze' then
            save.set('cutsceneHandler', {
              song = daSong,
              cutscene = 'mazeCutscene'
            })
            daSong = 'cutscene-handler'
          end
          loadSong(daSong, -1)
        end
      end
    end
    if not storyModeShit then
      loadSong(dofile('mods/'..currentModDirectory..'/modName.lua'), -1)
    end
    return Function_Stop;
  end
end
function onUpdate()
  if keyboardJustPressed('BACKSPACE') and songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua') and songName:lower() ~= 'enter-terminal' then
      loadSong(dofile('mods/'..currentModDirectory..'/modName.lua'), -1)
  end
end