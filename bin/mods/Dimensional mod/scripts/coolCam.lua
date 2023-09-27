--recreated cam system COOL!
--to enable/disable it run this in any lua script:
--callOnLuas('enableCam', {})
--callOnLuas('disableCam', {})
--you can also change onUpdate to sectionHit if you want ://///
--you can also force move the camera to a character by doing this:
--callOnLuas('forceMoveCam', {char}) ('boyfriend', 'dad', 'gf')
moveCam = false
camOffset = {0, 0}
curFocus = ''
function onCreatePost()
  if not inGameOver then
    setProperty('isCameraOnForcedPos', true)
    shitters = {
      {false, 'dad', getProperty('dad.cameraPosition'), {150, -100}},
      {true, 'boyfriend', getProperty('boyfriend.cameraPosition'), {-100, -100}},
      {'GFSECTION', 'gf', getProperty('gf.cameraPosition'), {0, 0}}
    }
  end
end
function onUpdate()
  if not inGameOver then
    if moveCam then
      for k,v in pairs(shitters) do
        if v[1] == mustHitSection or v[1] == 'GFSECTION' and gfSection then
          setProperty('camFollow.x', getMidpointX(v[2]) + v[4][1] + v[3][1] + camOffset[1])
          setProperty('camFollow.y', getMidpointY(v[2]) + v[4][2] + v[3][2] + camOffset[2])
          if curFocus ~= v[2] then
            callOnLuas('onMoveCamera', {v[2]})
            onMoveFocus(v[2])
          end
          curFocus = v[2]
        end
      end
    end
    if stringStartsWith(getProperty(curFocus..'.animation.curAnim.name'), 'idle') then
      camOffset = {0, 0}
    end
  end
end
function onMoveFocus(char)
  camOffset = {0, 0}
end

function onEvent(n, v1, v2)
  if n:lower() == 'change character' then
    shitters = {
      {false, 'dad', getProperty('dad.cameraPosition'), {150, -100}},
      {true, 'boyfriend', getProperty('boyfriend.cameraPosition'), {-100, -100}},
      {'GFSECTION', 'gf', getProperty('gf.cameraPosition'), {0, 0}}
    }
  end
end
function forceMoveCam(char)
  if not inGameOver then
    for k,v in pairs(shitters) do
      if v[2] == char then
        setProperty('camFollow.x', getMidpointX(v[2]) + v[4][1] + v[3][1] + camOffset[1])
        setProperty('camFollow.y', getMidpointY(v[2]) + v[4][2] + v[3][2] + camOffset[2])
        callOnLuas('onMoveCamera', {v[2]})
        if curFocus ~= v[2] then
          onMoveFocus(v[2])
        end
        curFocus = v[2]
      end
    end
  end
end
function onCountdownTick(swag)
  if not inGameOver then
    if swag == 0 or swag == 2 then
      forceMoveCam('boyfriend')
    elseif swag == 1 or swag == 3 then
      forceMoveCam('dad')
    end
  end
end
function onSongStart()
  if not inGameOver then
    moveCam = songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua')
  end
end
function enableCam()
  if not inGameOver then
    moveCam = true
  end
end
function disableCam()
  if not inGameOver then
    moveCam = false
  end
end
stupider = 25
coolShit = {{-stupider, 0}, {0, stupider}, {0, -stupider}, {stupider, 0}}
function opponentNoteHit(aa, data)
  if curFocus == 'dad' and not inGameOver then
    camOffset = coolShit[data+1]
  end
end
function goodNoteHit(aa, data)
  if curFocus == 'boyfriend' and not inGameOver then
    camOffset = coolShit[data+1]
  end
end