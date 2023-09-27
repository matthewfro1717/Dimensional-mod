--makes the ui look like dnb ui

--add credits here
coolCredits = {
  ['supernovae'] = 'Original Song made by ArchWk!',
  ['glitch'] = 'Original Song made by DeadShadow and PixelGH',
  ['mealie'] = 'Original Song made by Alexander Cooper 19!',
  ['unfairness'] = 'Ghost Tapping is forced off! FUCK YOU!',
  ['cheating'] = 'Notes are scrambled! FUCK YOU!',
  ['kabunga'] = 'OH MY GOD I JUST DEFLATED',
  ['opposition'] = 'NOTES ARE FLYING. FUCK YOU!',
  ['eletric-cockadoodledoo'] = 'Song by Cuzsie! (THIS SONG IS NOT CANON)',
  ['vs-dave-thanksgiving'] = 'What the hell!'
}

function onCreatePost()
  if songName:lower() ~= dofile('mods/'..currentModDirectory..'/modName.lua') then
    luaDebugMode = true
    local yeah = coolCredits[songName:lower()];
    if yeah ~= nil then
      makeLuaText('credits', yeah, 0, 4, getProperty('healthBarBG.y') + 50)
      addLuaText('credits')
    end
    makeLuaText('songtext', songName, 0, 4, getProperty('healthBarBG.y') + ((yeah == nil) and 50 or 30))
    addLuaText('songtext')

    setObjectOrder('healthBarBG', getObjectOrder('healthBar'))


    screenCenter('timeBar', 'X')
    setProperty('timeBar.y', getProperty('timeBar.y') + 5)
    addHaxeLibrary('FlxBar', 'flixel.ui')
    runHaxeCode([[
      game.timeBar.createFilledBar(0xFF101010, 0xFF39FF14);
    ]])
    setObjectOrder('timeBarBG', getObjectOrder('timeBar'))

    if songName:lower() == 'exploitation' then
      loadGraphic('healthBarBG', 'ui/HELLthbar')
    end
  end
  runHaxeCode([[
  FlxG.mouse.visible = true;
  ]])
end
