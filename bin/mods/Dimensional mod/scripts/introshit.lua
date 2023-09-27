--add your song in creditsStuff.txt bambi-unfair


coolData = {}
stupid = { --if the animation doesnt work properly try putting it here
  ['bambi-3d, bambi-unfair, expunged, playrobot, moldy'] = 'Bambi-3d, Bambi-unfair, Expunged, Playrobot, Moldy'
}
function onCreatePost()
  if songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua') then
    coolData = getData(songName)
    if coolData.headerXml == nil then
      makeLuaSprite('heading', 'songHeadings/'..coolData.header, -308, 200)
    else
      makeAnimatedLuaSprite('heading', 'songHeadings/'..coolData.header, -308, 200)
      addAnimationByPrefix('heading', 'idle', stupid[dadName])
      playAnim('heading', 'idle')
    end
    setProperty('heading.antialiasing', coolData.antialiasing)
    setGraphicSize('heading', 308, 45)
    setObjectCamera('heading', 'hud')
    addLuaSprite('heading', true)

        
       addLuaScript('introshit (1)')
        
      makeLuaSprite('creditsIcon', 'songCreators/'..coolData.composer, 0, 200)
      setProperty('creditsIcon.antialiasing', coolData.antialiasing)
      setObjectCamera('creditsIcon', 'hud')
      setGraphicSize('creditsIcon', 45, 45)
      addLuaSprite('creditsIcon', true)

      makeLuaText('songComposerText', 'Song by '..coolData.composer, 0, 0, 200)
      setTextSize('songComposerText', 30)
      addLuaText('songComposerText', true)
 
    if coolData.intro ~= nil then
      setProperty('introSoundsSuffix', '_'..coolData.intro)
    end
    if coolData.intro ~= 'dave' then
      setProperty('introSoundsSuffix', 'dave'..coolData.intro)
    end
    if coolData.intro ~= 'bambi' then
      setProperty('introSoundsSuffix', 'bambi'..coolData.intro)
    end
  end
end
function onUpdate()
  local fuckthis = fuckingCool and -100 or 2
  setProperty('creditsIcon.x', getProperty('heading.x') + 262.95)
  setProperty('songComposerText.x', getProperty('heading.x') + fuckthis)
end
function onSongStart(swag)
  doTweenX('headingHI', 'heading', 65.1, 0.3*2.4, 'cubeOut')
  ezTimer(nil, 0.3*2.4, function()
    doTweenX('headingHI', 'heading', 0, 0.3*2.4, 'cubeInOut')
    ezTimer(nil, 3, function()
      doTweenX('headingHI', 'heading', 65.1, 0.3*2.4, 'cubeInOut')
      ezTimer(nil, 0.3*2.4, function()
        doTweenX('headingHI', 'heading', -3008, 0.2*2.4, 'cubeInOut')
      end)
    end)
  end)
end
function getData(song)
  local aa = split(getTextFromFile('creditsStuff.txt'), '\n')
  local data = {}
  for k,v in pairs(aa) do
    local shitter = split(v, ', ')
    if shitter[1] == song then
      local penis = {song = shitter[1], composer = shitter[2], header = shitter[3], intro = shitter[4], headerXml = shitter[6], antialiasing = shitter[5]};
      local checkNil = function(inp)
        return inp == nil or #inp <= 1 or inp == '';
      end
      if checkNil(penis.composer) then penis.composer = 'None' end
      if checkNil(penis.header) then penis.header = 'tristanHeading' end
      if checkNil(penis.intro) then penis.intro = nil end
      if penis.headerXml == 'NO' then penis.headerXml = nil end
      penis.antialiasing = penis.antialiasing == 'true'
      return penis;
    end
  end
  return {song = song, composer = 'Unknown!', header = 'tristanHeading'}
end
function split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
timers = {blankTags = 0}
function ezTimer(tag, timer, callback)
  if tag == nil then
    tag = 'blank_tags-'..tostring(timers.blankTags)
    timers.blankTags = timers.blankTags + 1
  end
  timers[tag] = callback
  runTimer(tag, timer)
end
function onTimerCompleted(tag)
  if timers[tag] ~= nil then
    timers[tag]()
    timers[tag] = nil
    if stringStartsWith(tag, 'blank_tags-') then
      timers.blankTags = tonumber(stringSplit(tag, '-')[2])
    end
  end
end