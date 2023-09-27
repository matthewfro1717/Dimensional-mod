--this is very complicated and stupid sorry
--NOTE MOD SPECIFIC OPTIONS: NOTE

onlyEssentials = false --set this to false to see buttons like options and credits and ost and fdsother stuff :)_)))
specialIcons = {'terminal', 'bambi-loser'} --icons that dont have losing versions
freeplayPacks = {
  {'dave', 'joke', 'extras', 'fanmade', 'old', 'terminal'}, --image names (images/title/packs)
  {'story', 'joke', 'extra', 'fanmade', 'old', 'console'} --display names
}
freeplayGroups = { --names of the week files for each pack
  {'week0', 'week1', 'week2', 'week3', 'week4'}, --first pack in the list
  {'week5', 'secret', 'extrajokefanmadeold'}, --second pack, etc
  {'extra'},
  {'fanmade'},
  {'old'},
  {'console'},
  {'secret'}
}
characterSelectChars = { --list of variations, each char obj is char file, display name, and whether it needs to be unlocked or not, 3d strum
  {{'bf', 'Boyfriend'}, {'bf-rap', 'Pixel Boyfriend'}},
  {{'dave-playable', 'Dave', true}},
  {{'dave-annoyed', 'Dave-pissed', true}},
  {{'dave-splitathon', 'Dave-Splitathon', true}},
  {{'dave-festival', 'Dave-Festival', true}},                                            
  {{'dave-old', 'Old-Dave', true}}, 
  {{'bambi-new-playable', 'Bambi', true}},
  {{'bambi-splitathon', 'Bambi-Splitathon', true}},
  {{'bambi-angey', 'Bambi-Angry', true}},
  {{'bambi', 'bambi-old', true}}, 
  {{'bambi-madddddd', 'bambi-screwed', true}},
  {{'betabambi', 'Betabambi', true}},
  {{'bambiold', 'bambi-alpha', true}},
  {{'bambi-joke', 'mr-bambi', true}},
  {{'bambi-joke-mad', 'mr-bambi-mad', true}},
  {{'tristan', 'Tristan'}},
  {{'tristan-old', 'Old-Tristan'}},
  {{'tristan-beta', 'Beta-Tristan'}},
  {{'tristan-golden', 'Golden Tristan', true}},
  {{'diamond-tristan', 'Diamond-Tristan', true}},
  {{'dave-angey-playable', '3D Dave', true, true}},
  {{'bambi-3d-playable', '3D Bambi', true, true}},
  {{'bambi-unfair', 'Unfair 3D Bambi', true, true}},
  {{'expunged', 'DATA EXPUNGED', true, true}}
}
storyModeWeeks = {'week0', 'week1', 'week2', 'week3', 'week4'}
colors = { --color shortcuts, you can change these if you want
  ['main'] = '0xFFFDE871', --default as yellow
  ['selected'] = '0xFFfd719b', --default as magenta
  ['other'] = '0xFF4965FF' --defaut as blue
}

--NOTE THE ACTUAL CODE FOR THE MENUS NOTE







menu = 'main' --menu name
menuObjects = {} --objects that will be removed when a menu is changed
menuText = {} --text that will be removed when a menu is changed
haxeStuffToRemove = {} --other stuff
bgs = {}
menuVars = {}
json = {}
optionsShit = {}
options = {}
prevMenus = {[0] = 'BACK'}
menuNum = 0
timesInFreeplay = 0 --fixes really odd haxe issue
function onCreate()
  debugPrint('the strart!!')
  addHaxeLibrary('FlxGradient', 'flixel.util')
  addHaxeLibrary('CoolUtil')
  addHaxeLibrary('Std')
  addHaxeLibrary('Alphabet')
  addHaxeLibrary('HealthIcon')
  addHaxeLibrary('FlxMath', 'flixel.math')
  addHaxeLibrary('Highscore')
  addHaxeLibrary('Boyfriend')
  addHaxeLibrary('MenuItem')
  luaDebugMode = true
  addAnim = addAnimationByPrefix
  local FAKEbgs = directoryFileList('mods/'..currentModDirectory..'/images/title/backgrounds')
  for i,v in pairs(FAKEbgs) do
    if FAKEbgs[i]:lower() ~= 'nostalgia' then
      table.insert(bgs, split(v, '.')[1])
    end
  end
  playMusic('freakyMenu', true)
  
  initSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
  if save.get('firstBoot') == nil then
    save.set('firstBoot', true)
  end
  save.set('startCutscene', nil)
  save.set('terminalModChart', nil)
  ----debugPrint(save.get'foundJoke')
  -- options = options.decode(save.get('optionsShits'));
end
save = {}
function save.get(field, other)
  if field == nil then return false end
  return getDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, other)
end
function save.set(field, value)
  setDataFromSave(dofile('mods/'..currentModDirectory..'/saveData.lua'), field, value)
end
function onDestroy()
  save.set('firstBoot', false)
  if not enteringSong then
    save.set('globalGuys', nil)
  end
  flushSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
end
function onCreatePost()
  setProperty('camHUD.visible', false)
  setProperty('camGame.visible', false)
  
  local daMenu = 'main'
  local globalMenuNil = true
  
  ------------debugPrint('gonna try to get globalers')
  if save.get('globalGuys') ~= nil then
    if save.get('globalGuys').menu ~= nil then
      ------------debugPrint('globalers found')
      daMenu = save.get('globalGuys').menu
      ----debugPrint(daMenu)
      menuOrders = {
        ['freeplay'] = {'main', 'freeplaySelect'},
        ['credits'] = {'credits', 'freeplaySelect'},
        ['story'] = {'main'}
      }
      menuNums = { --wtf!!
        ['freeplay'] = 2,
        ['credits'] = 3,
        ['story'] = 1
      }
      ------------debugPrint('globalers found2')
      prevMenus = menuOrders[daMenu]
      ------------debugPrint(menuNums[daMenu] == nil)
      menuNum = menuNum + tonumberNil(menuNums[daMenu]) --fuck this
      globalMenuNil = false
      --this is stupid :(
    end
    ------------debugPrint(save.get('globalGuys'))
    ------------debugPrint('got globalers :)')
    -- ----debugPrint(prevMenus..', '..menuNum)
  end
  ------------debugPrint('probably did not get globalers')
  
  makeMenu(daMenu, true, false, save.get('globalGuys'))
  makeLuaText('songtext', 'Amplified Edition v1.0', 0, 4, getProperty('healthBarBG.y') + 50)
  setObjectCamera('songtext', 'other')
  addLuaText('songtext', true)
  precacheImage('title/transition')
  
  save.set('globalGuys', nil)
end
function onGameOver()
  return Function_Stop
end
function addShit(what)
  return dofile('mods/'..currentModDirectory..'/'..what..'.lua')
end
function fixNil(inp)
  local converted = inp
  if converted == nil or converted == 'nil' then
    converted = 'null'
  end
  return converted
end
function makeAlphabet(tag, text, x, y, bold, alignment) --i stole this :)
    runHaxeCode([[
      if (game.modchartSprites.exists(']]..tag..[[')) 
      { 
        game.modchartSprites.get(']]..tag..[[').kill(); 
        game.modchartSprites.get(']]..tag..[[').destroy(); 
      } 
      textThingy = new Alphabet(0, 0, ']]..text..[[', ]]..tostring(bold)..[[);
      // textThingy.length = 0;
      textThingy.cameras = [game.camOther];
      game.add(textThingy); 
      game.modchartSprites.set(']]..tag..[[', textThingy); 
      textThingy.x += ]]..tostring(x)..[[; textThingy.y += ]]..tostring(y)..[[; 
      textThingy.members.x += ]]..tostring(x)..[[; 
      textThingy.members.y += ]]..tostring(y)..[[;
      //////trace(game.members);
      textThingy.setAlignmentFromString(']]..alignment..[[');
      textThingy.updateAlignment();
    ]])
    table.insert(haxeStuffToRemove, tag)
end
function contains(tab, what)
  for k,v in pairs(tab) do
    if what == v then
      return true;
    end
  end
  return;
end
beenThere = {}
function makeMenu(menu, skipTrans, backwards, carryOver)
  ----------debugPrint('NEW MENU: '..menu)
  local menuStuff = {
    ['main'] = function()
      if not onlyEssentials then
        menuVars = {
          curSelected = 1,
          hasSelected = false,
          selectionMenu = {'story', 'freeplaySelect', 'credits', 'ost', 'options', 'discord'}, --menu names
          menuDisplays = {
            {'Story Mode', 'Play the story to unlock new characters, and understand the story!'},
            {'Freeplay', 'Play any song as you wish and get new scores!'},
            {'Credits', 'Look at the people who have worked or contributed to the mod!'},
            {'OST', 'Listen to the songs of the mod.'},
            {'Settings', 'Adjust like two settings lol'},
            {'Discord', 'Join the offical Vs. Dave and Bambi Discord!'}
          },
          icons = {'story mode', 'freeplay', 'credits', 'ost', 'options', 'discord'}
        }
      else
        menuVars = {
          curSelected = 1,
          hasSelected = false,
          selectionMenu = {'story', 'freeplaySelect', 'credits'}, --menu names
          menuDisplays = {
            {'Story Mode', 'Play the story to unlock new characters, and understand the story!'},
            {'Freeplay', 'Play any song as you wish and get new scores!'},
            {'Credits', 'Look at the people who have worked or contributed to the mod!'}
          },
          icons = {'story mode', 'freeplay', 'credits'}
        }
      end
      if carryOver ~= nil then
        if carryOver.song ~= nil then
          menuVars.song = carryOver.song
          menuVars.group = carryOver.group
        end
      end
      menuVars.changeSelection = function(what)
        playSound('scrollMenu')
        local newSelected = menuVars.curSelected + what
        if newSelected > #menuVars.selectionMenu then
          newSelected = 1
        end
        if newSelected < 1 then
          newSelected = #menuVars.selectionMenu
        end
        menuVars.curSelected = newSelected
        for k,v in pairs(menuVars.selectionMenu) do
          -- ------------------debugPrint(v..', '.. menuVars.curSelected)
          if menuVars.curSelected == k then
            playAnim('icon_'..v, 'selected')
          else
            playAnim('icon_'..v, 'idle')
          end
        end
        playAnim('bigIcon', menuVars.selectionMenu[menuVars.curSelected])
        setTextString('displayER', menuVars.menuDisplays[menuVars.curSelected][1])
        setTextString('descriptor', menuVars.menuDisplays[menuVars.curSelected][2])
        -- ------------------debugPrint('oh sdhit')
      end
      makeBG('bg', 0, 0, 'main')
      add('bg')
      
      makeSpr('selectthing', 'mainMenu/Select_Thing')
      add('selectthing')
      
      makeSpr('bigIcon', 'menu_big_icons', 0, 0, true)
      screenCenter('bigIcon', 'X')
      for k,v in pairs(menuVars.icons) do
        addAnim('bigIcon', menuVars.selectionMenu[k], v..'0')
        
        makeSpr('icon_'..menuVars.selectionMenu[k], 'main_menu_icons', 190 + (160 * (k-1)), screenHeight / 2 + 130, true)
        setGraphicSize('icon_'..menuVars.selectionMenu[k], 128, 128)
        addAnim('icon_'..menuVars.selectionMenu[k], 'idle', v..' basic')
        addAnim('icon_'..menuVars.selectionMenu[k], 'selected', v..' white')
        playAnim('icon_'..menuVars.selectionMenu[k], 'idle')
        add('icon_'..menuVars.selectionMenu[k])
      end
      add('bigIcon')
      
      makeText('displayER', 1000)
      -- runHaxeCode([[
      --   ////trace(FlxTextAlign.fromOpenFL);
      --   PlayState.instance.modchartTexts.get('displayER').setFormat('Comic Sans MS Bold', 50, 0xFFFFFFFF, 'CENTER');
      -- ]])
      setTextAlignment('displayER', 'center')
      screenCenter('displayER')
      setTextSize('displayER', 50)
      setPos('displayER', getProperty('displayER.x') - 135, getProperty('displayER.y') + 40)
      addText('displayER')
      
      makeText('descriptor', 1000)
      screenCenter('descriptor')
      setTextAlignment('descriptor', 'center')
      setTextSize('descriptor', 25)
      setPos('descriptor', getProperty('descriptor.x') - 500, getProperty('descriptor.y') + 300)
      addText('descriptor')
      
      menuVars.changeSelection(0)
    end,
    ['freeplaySelect'] = function()
      ------------------debugPrint('uh oh')
        --------------debugPrint('sdg1')
      local stupidCarryOver = 0
      if carryOver ~= nil then
        if carryOver.group ~= nil then
          stupidCarryOver = carryOver.group
        end
      end
      menuVars = {
        curSelected = stupidCarryOver,
        packs = freeplayPacks[1],
        realNames = freeplayPacks[2],
        focusPos = {0, 1, 2, 3},
        hasSelected = false,
        mainOffset = 0,
        offsetPoint = 0
      }
      --------------debugPrint('sdg1')
      if save.get('unlockedConsole') then
        table.insert(menuVars.packs, 'console')
      end
      --------------debugPrint('sdg1')
      menuVars.changeSelection = function(what)
        -- playSound('scrollMenu')
        local newSelected = menuVars.curSelected + what
        if newSelected > #menuVars.packs then
          newSelected = 1
          what = -2
        end
        if newSelected < 1 then
          newSelected = #menuVars.packs
          what = 2
        end
        menuVars.curSelected = newSelected
        menuVars.offsetPoint = (menuVars.curSelected-1)*-1280
        ----------------debugPrint(getProperty('dave.x')..', '..menuVars.curSelected)
        -- ----------------debugPrint(menuVars.packs[menuVars.curSelected])
      end
      
      menuVars.bg = makeBG('bg', 0, 0, 'other', backwards and carryOver.bg or nil)
      add('bg')
      
      for k,v in pairs(menuVars.packs) do
        makeSpr(v, 'packs/'..v)
        screenCenter(v)
        add(v)
        
        makeAlphabet(v..'_TEXT', menuVars.realNames[k]:upper(), 0, 0, true, 'center')
        if backwards then
          local stupidIdiot = getProperty(v..'.y')
          setProperty(v..'.y', - 25)
          setProperty(v..'.alpha', 0)
          doTweenY('ok come if'..v, v, stupidIdiot, 0.1, 'sineIn')
          doTweenAlpha('okdfsa'..v, v, 1, 0.1, 'sineIn')
        end
      end
      --------------debugPrint('sdgFINAKL')
      -- runHaxeCode([[
      --   FlxG.watch.add(game.getLuaObject(']]..v..[['), "x", ']]..v..[[');
      -- ]])
      menuVars.changeSelection(1);
    end,
    ['freeplay'] = function()
      timesInFreeplay = timesInFreeplay + 1 --prevents stupid ass haxe crash for some reason
      menuVars = {
        curSelected = 1,
        hasSelected = false,
        bg = '',
        group = 0,
        groups = freeplayGroups,
        songs = {},
        offset = {x = 0, y = 0},
        lerpOffset = {x = 0, y = 0}
      }
      menuVars.changeSelection = function(what)
        playSound('scrollMenu')
        local newSelected = menuVars.curSelected + what
        if newSelected > #menuVars.songs then
          newSelected = 1
          what = -2
        end
        if newSelected < 1 then
          newSelected = #menuVars.songs
          what = 2
        end
        menuVars.curSelected = newSelected
        for k,v in pairs(menuVars.songs) do
          setProperty(v.alphabet..'.targetY', k - menuVars.curSelected)
          setProperty(v.alphabet..'.alpha', 0.6)
          if getProperty(v.alphabet..'.targetY') == 0 then
            setProperty(v.alphabet..'.alpha', 1)
            if menuVars.songs[newSelected].chart:lower() ~= 'enter-terminal' then
              runHaxeCode([[
                FlxG.sound.playMusic(Paths.inst(']]..v.chart..[['), 0);
              ]])
            end
          end
          ------------debugPrint(v.iconName)
          setProperty(v.iconName..'.alpha', getProperty(v.alphabet..'.alpha'))
          
          --music :)
        end
        doTweenColor('freeplayColor', 'bg', menuVars.songs[newSelected].color, 0.25)
        ----------debugPrint(getScore(menuVars.songs[menuVars.curSelected].chart))
        ------------debugPrint(menuVars.songs[newSelected])
      end
      if carryOver ~= nil then
        menuVars.group = carryOver.group
        if carryOver.curSelected ~= nil then
          menuVars.curSelected = carryOver.curSelected
        end
      end
      if save.get('unlockedConsole') then
        groups[2] = {'console', 'console'}
      end
      menuVars.bg = makeBG('bg', 0, 0, 'other', carryOver.bg)
      add('bg')
      
      local daGroup = menuVars.groups[menuVars.group];
      
      local weekData = {} --get all the week data
      local daJsons = directoryFileList('mods/'..currentModDirectory..'/weeksREAL') --WTF THEY ARENT JSONS!!!
      -- local daOrder = dofile('mods/'..currentModDirectory..'/weeksList.lua')[menuVars.group]
      -- ------debugPrint(daOrder)
      ------debugPrint(daJsons)
      for k,v in pairs(daJsons) do
        if contains(menuVars.groups[menuVars.group], split(v, '.')[1]) then
          local stuff = dofile('mods/'..currentModDirectory..'/weeksREAL/'..v)
          ------debugPrint(indexOf(daGroup, split(v, '.')[1]))
          stuff.jsonName = v
          table.insert(weekData, tonumber(indexOf(daGroup, split(v, '.')[1])), stuff) --put it in the correct order
        end
      end
      
      ------debugPrint(weekData)
      
      for k,v in pairs(weekData) do
        ------debugPrint(v.jsonName)
      end
      
      for k,v in pairs(weekData) do
        for i,o in pairs(v.songs) do
          local coolColor = v.color == 'SONG_SPECIFIC' and o[15] or v.color 
          if colors[coolColor] ~= nil then coolColor = colors[coolColor] end
          local song = {
            name = o[1]:gsub('-', ' '),
            chart = o[1]:lower(),
            icon = o[2],
            iconName = o[1]:gsub('-', '')..tostring(timesInFreeplay):lower(),
            color = coolColor,
            saveRequirement = o[4], --save data needed to show the song
            alphabet = o[1]..tostring(timesInFreeplay):lower()
          }
          local stupidFuckingSave = o[4]
          local yesGoThroughYesYES = false
          if stupidFuckingSave ~= nil then
            ------debugPrint(song.name..', '..stupidFuckingSave..', '..tostring(save.get(stupidFuckingSave) == nil))
            if save.get(stupidFuckingSave) ~= nil then --wtf????
              yesGoThroughYesYES = save.get(stupidFuckingSave)
            end
          else
            yesGoThroughYesYES = true
          end
          if yesGoThroughYesYES then
            table.insert(menuVars.songs, song)
            -- ------debugPrint(song.name)
          end
        end
      end
      
      --add songs
      for k,song in ipairs(menuVars.songs) do
        makeAlphabet(song.alphabet, song.name, 90, 720, true, 'left')
        setProperty(song.alphabet..'.isMenuItem', true)
        setProperty(song.alphabet..'.targetY', k - menuVars.curSelected)
        setProperty(song.alphabet..'.startPosition.x', 90)
        setProperty(song.alphabet..'.startPosition.y', 320)
        runHaxeCode([[
          game.modchartSprites.get(']]..song.alphabet..[[').y += 720;
        ]])
        
        local healthIcon = song.iconName..'_ICON'
        local specialIcon = false
        for k,v in pairs(specialIcons) do
          if v == song.icon then
            specialIcon = true
          end
        end
        if not specialIcon then
          runHaxeCode([[
            var ]]..healthIcon..[[ = new HealthIcon(']]..song.icon..[[');
            ]]..healthIcon..[[.cameras = [game.camOther];
            ]]..healthIcon..[[.sprTracker = game.modchartSprites.get(']]..song.alphabet..[[');
            //trace(']]..healthIcon..[[');
            game.add(]]..healthIcon..[[);
            game.modchartSprites.set(']]..healthIcon..[[', ]]..healthIcon..[[);
          ]])
          table.insert(haxeStuffToRemove, healthIcon)
        else
          ------debugPrint('specail icin!!!')
          runHaxeCode([[
            var ]]..healthIcon..[[ = new HealthIcon(']]..song.icon..[[');
            ]]..healthIcon..[[.loadGraphic(Paths.image(']]..('icons/'..song.icon)..[['));
            ]]..healthIcon..[[.offset.set(10, 10);
            ]]..healthIcon..[[.cameras = [game.camOther];
            ]]..healthIcon..[[.sprTracker = game.modchartSprites.get(']]..song.alphabet..[[');
            //trace(']]..healthIcon..[[');
            game.add(]]..healthIcon..[[);
            game.modchartSprites.set(']]..healthIcon..[[', ]]..healthIcon..[[);
          ]])
          table.insert(haxeStuffToRemove, healthIcon)
        end
        song.iconName = healthIcon
        -- ------------debugPrint(song.iconName)
      end
      -- ------------debugPrint(daJsons)
      --score
      
      -- makeText('scoreTxt', 'PERSONAL SCORE: 0', 0, screenWidth * 0.7, 5)
      -- setTextSize('scoreTxt', 32)
      -- setTextAlignment('scoreTxt', 'right')
      -- addText('scoreTxt')

      -- makeSpr('bgthing', 'title/checkeredBG')
      -- setSpriteShader('bgthing', 'RepeatingBitch')
      -- setGraphicSize('bgthing', 1280, 720)
      -- add('bgthing')
       
      -- makeSpr('scoreBG', '', getProperty('scoreTxt.x' - 6))
      -- makeGraphic(runHaxeCode('return Std.int(FlxG.width * 0.35);'), 66, '000000')
      -- ----------debugPrint('we are here now')
      -- setProperty('scoreBG.alpha', 0.6)
      -- setProperty('scoreBG.y', getProperty('scoreBG.y') - 200)
      -- add('scoreBG')
      menuVars.changeSelection(0);
      ----------debugPrint('we are here now')
    end,
    ['charSelect'] = function()
      ----------debugPrint('oh yeah')
      prevMenus = {'main', 'freeplaySelect', 'charSelect'}
      menuNum = 3
      menuVars = {
        curSelected = 1,
        curForm = 1,
        chars = characterSelectChars,
        changeSelection = function(what, huh)
          playSound('scrollMenu')
          local newSelected = menuVars.curSelected
          local newForm = menuVars.curForm
          if huh == nil then
            newSelected = menuVars.curSelected + what
            if newSelected > #menuVars.chars then
              newSelected = 1
            end
            if newSelected < 1 then
              newSelected = #menuVars.chars
            end
            menuVars.curSelected = newSelected
          else
            newForm = menuVars.curForm + newForm
            if newSelected > #menuVars.chars[newSelected][newForm][1] then
              newForm = 1
            end
            if newSelected < 1 then
              newSelected = #menuVars.chars[newSelected][newForm][1]
            end
            menuVars.newForm = newForm
          end
          
          --update char
          ----------debugPrint('gonna update awesome, ')
          runHaxeCode([[
            //trace('hmmm yeah');
            if(game.modchartSprites.exists('daPlayer'))
            {
              //trace('DIE DIE DIE DEATH DEATH DEATH KILL KILL');
              game.modchartSprites.get('daPlayer').kill();
              game.modchartSprites.get('daPlayer').destroy();
              game.modchartSprites.remove('daPlayer');
              //trace('ok im good');
            }
            var daPlayer = new Boyfriend(0, 0, ']]..tostring(menuVars.chars[newSelected][newForm][1])..[[');
            daPlayer.screenCenter();
            daPlayer.cameras = [game.camOther];
            daPlayer.scale.set(0.75, 0.75);
            for(offset in daPlayer.animOffsets)
            {
              offset[0] *= 0.75;
              offset[1] *= 0.75;
            }
            game.add(daPlayer);
            game.modchartSprites.set('daPlayer', daPlayer);
            //trace('YES dude OH YEAH');
          ]])
        end,
        singReset = -1
      }
      if carryOver ~= nil then
        menuVars.songNum = carryOver.songNum
        menuVars.group = carryOver.group
        menuVars.song = carryOver.song
      end
      if not expungedMode then
        makeSpr('night', 'backgrounds/shared/sky_night', -847.55, -312.5, false, true)
      else
        makeBG('night', -847.55, -312.5)
      end
      scaleObject('night', 1.2, 1.2)
      add('night')
      
      makeSpr('farHills', 'backgrounds/charSelect/hills', -114.6, 59.85, false, true)
      scaleObject('farHills', 1.2, 1.2)
      add('farHills')
      
      makeSpr('house', 'backgrounds/charSelect/house', 398.9, 78, false, true)
      scaleObject('house', 1.2, 1.2)
      add('house')
      
      makeSpr('gateRight', 'backgrounds/charSelect/gateRight', 1088.9, 485.15, false, true)
      scaleObject('gateRight', 1.2, 1.2)
      add('gateRight')
      
      makeSpr('gateLeft', 'backgrounds/charSelect/gateLeft', -173.15, 485.15, false, true)
      scaleObject('gateLeft', 1.2, 1.2)
      add('gateLeft')
      
      makeSpr('grass', 'backgrounds/charSelect/grass', -223.9, 390.35, false, true)
      scaleObject('grass', 1.2, 1.2)
      add('grass')
      
      makeSpr('frontGrass', 'backgrounds/charSelect/frontGrass', -107.9, 441.45, false, true)
      scaleObject('frontGrass', 1.2, 1.2)
      add('frontGrass')
      
      for k,v in pairs(menuObjects) do
        setProperty(v..'.color', getColorFromHex('0xFF878787'))
      end
      
      
      runHaxeCode([[
        var daPlayer = new Boyfriend(0, 0, 'bf');
        daPlayer.screenCenter();
        daPlayer.cameras = [game.camOther];
        daPlayer.scale.set(0.75, 0.75);
        for(offset in daPlayer.animOffsets)
        {
          offset[0] *= 0.75;
          offset[1] *= 0.75;
        }
        game.add(daPlayer);
        game.modchartSprites.set('daPlayer', daPlayer);
        
        FlxG.sound.playMusic(Paths.music(']]..(expungedMode and 'badEnding' or 'goodEnding')..[['), 1);
      ]])
      table.insert(haxeStuffToRemove, 'daPlayer')
      ----------debugPrint('coc')
      runTimer('goLoopShit', 2.18)
      
      
      
      makeSpr('guide', 'charSelectGuide', 27.3, 27.6)
      scaleObject('guide', 1.1, 1.1)
      add('guide')
      
      makeSpr('ArrowLeft_Idle', 'ArrowLeft_Idle', 167.55, 291.6)
      scaleObject('ArrowLeft_Idle', 0.75, 0.75)
      add('ArrowLeft_Idle')
      
      makeSpr('ArrowRight_Idle', 'ArrowRight_Idle', 924.45, 291.6)
      scaleObject('ArrowRight_Idle', 0.75, 0.75)
      add('ArrowRight_Idle')
      
      makeSpr('ArrowLeft_Pressed', 'ArrowLeft_Pressed', 167.55, 291.6)
      scaleObject('ArrowLeft_Pressed', 0.75, 0.75)
      setProperty('ArrowLeft_Pressed.visible', false)
      add('ArrowLeft_Pressed')
      
      makeSpr('ArrowRight_Pressed', 'ArrowRight_Pressed', 924.45, 291.6)
      scaleObject('ArrowRight_Pressed', 0.75, 0.75)
      setProperty('ArrowRight_Pressed.visible', false)
      add('ArrowRight_Pressed')
    end,
    ['story'] = function()
      ----debugPrint('ok')
      menuVars = {
        curSelected = 1,
        weeks = storyModeWeeks,
        weekStuff = {},
        coolOffset = 0,
        mainOffset = 418.5,
        offsetPoint = 0,
        hasSelected = false
      }
      menuVars.changeSelection = function(what)
        playSound('scrollMenu')
        local newSelected = menuVars.curSelected + what
        if newSelected > #menuVars.weeks then
          newSelected = 1
          what = -2
        end
        if newSelected < 1 then
          newSelected = #menuVars.weeks
          what = 2
        end
        menuVars.curSelected = newSelected
        ----debugPrint(menuVars.weekStuff[newSelected].color)
        doTweenColor('storyColor', 'yellowBG', menuVars.weekStuff[newSelected].color, 0.25)
        -- doTweenAlpha('bitchBitch')
        for k,v in pairs(menuVars.weeks) do
          if menuVars.curSelected == k then
            setProperty('weekMenuItem'..k..'.alpha', 1)
            doTweenAlpha(v..'AlphaShit', 'weekBanner'..k, 1, 0.1)
          else
            setProperty('weekMenuItem'..k..'.alpha', 0.6)
            doTweenAlpha(v..'AlphaShit', 'weekBanner'..k, 0, 0.1)
          end
        end
        menuVars.offsetPoint = (menuVars.curSelected-1)*-420
        local fucking = menuVars.weekStuff[menuVars.curSelected].weekName
        if menuVars.weekStuff[menuVars.curSelected].songs[1]:lower() == 'supernovae' then --idk if this works but i dont want to test it lol
          fucking = '????????'
        end
        removeLuaText('txtWeekTitle')
        makeText('txtWeekTitle', fucking, 0, screenWidth * 0.7, 0)
        setTextSize('txtWeekTitle', 32)
        setProperty('txtWeekTitle.alpha', 0.7)
        addText('txtWeekTitle')
        setTextAlignment('txtWeekTitle', 'RIGHT')
        
        removeLuaText('txtTrackdeco')
        makeText('txtTrackdeco', 'Tracks'..menuVars.weekStuff[menuVars.curSelected].trackList, screenWidth, 0, getProperty('yellowBG.x') + getProperty('yellowBG.height') + 50)
        setTextSize('txtTrackdeco', 28)
        setTextAlignment('txtTrackdeco', 'CENTER')
        setProperty('txtTrackdeco.color', getColorFromHex('0xFFe55777'))
        screenCenter('txtTrackdeco', 'X')
        addText('txtTrackdeco')
      end
      local stupidJokeShit = false
      ----debugPrint('ok thihng')
      if save.get'foundJoke' then
        ----debugPrint('bithc')
        local fuckingFuckPsychLua = false
        fuckingFuckPsychLua = save.get'clickedJoke' ~= nil
        if fuckingFuckPsychLua then
          table.insert(menuVars.weeks, 'week5')
        else
          table.insert(menuVars.weeks, 'weekquestionmark')
          stupidJokeShit = true
        end
      end
      local changeSelectThing = 0
      if carryOver ~= nil then
        if carryOver.daWeek ~= nil then
          changeSelectThing = carryOver.daWeek
        end
      end
      -- trans() --idk
      --copied from freeplay menu lol, just a bit different!
      local weekData = {} --get all the week data
      local weekStuff = menuVars.weekStuff --simplified version
      local daJsons = directoryFileList('mods/'..currentModDirectory..'/weeksREAL') --WTF THEY ARENT JSONS!!!
      -- local daOrder = dofile('mods/'..currentModDirectory..'/weeksList.lua')[menuVars.group]
      -- ------debugPrint(daOrder)
      ------debugPrint(daJsons)
      for k,v in pairs(daJsons) do
        if contains(menuVars.weeks, split(v, '.')[1]) or stupidJokeShit and split(v, '.')[1] == 'week5' then
          local stuff = dofile('mods/'..currentModDirectory..'/weeksREAL/'..v)
          ------debugPrint(indexOf(daGroup, split(v, '.')[1]))
          stuff.jsonName = v
          if stupidJokeShit and split(v, '.')[1] == 'week5' then
            stuff.fakeSongs = {'???', '???', '???'}
          end
          table.insert(weekData, stuff)
        end
      end
      for id,week in pairs(weekData) do
        --debugPrint(week.jsonName)
        local simpleWeek = {
          id = id, 
          trackList = '\n',
          weekName = week.name,
          banner = week.banner,
          color = week.storyColor,
          songs = {}
        }
        local songArray = week.songs
        if week.fakeSongs ~= nil then
          --debugPrint('song array incoming!!!')
          --debugPrint(songArray)
          --debugPrint('ok that was the song arary')
          simpleWeek.banner = '????????'
          simpleWeek.trackList = '\n??? - ??? - ???' --god damnit!
        else
          for k,v in pairs(songArray) do --make track list string
            if k ~= 1 then
              simpleWeek.trackList = simpleWeek.trackList..' - '..v[1]
            else
              simpleWeek.trackList = simpleWeek.trackList..v[1]
            end
          end
        end
        for k,v in pairs(songArray) do
          table.insert(simpleWeek.songs, v[1])
        end
        --debugPrint(simpleWeek)
        table.insert(weekStuff, simpleWeek)
      end
      
      --debugPrint('yeah dude')
      makeText('txtWeekTitle', 'hey guys', 0, screenWidth * 0.7, 0)
      setTextSize('txtWeekTitle', 32)
      setProperty('txtWeekTitle.alpha', 0.7)
    
      
      makeSpr('blackBarThingie', '', 0, 0, false, true)
      makeGraphic('blackBarThingie', screenWidth, 57, '000000')
      add('blackBarThingie')
      
      makeSpr('yellowBG', '', 0, 56, false, true)
      makeGraphic('yellowBG', screenWidth * 2, 400, 'FFFFFF')
      setProperty('yellowBG.color', getColorFromHex(menuVars.weekStuff[menuVars.curSelected].color))
      
      for k,v in pairs(menuVars.weeks) do
        local sprName = 'weekMenuItem'..tostring(k)
        makeSpr(sprName, 'storymenu/'..v, 0, getProperty('yellowBG.y') + getProperty('yellowBG.height') + 80)
        add(sprName)
        
        screenCenter(sprName, 'X')
        ----debugPrint(k)
        -- runHaxeCode([[
        --   FlxG.watch.add(game.getLuaObject(']]..sprName..[['), "x", ']]..sprName..[[');
        -- ]])
      end
      add('yellowBG')
      
      makeText('txtTrackdeco', 'Tracks'..menuVars.weekStuff[menuVars.curSelected].trackList, screenWidth, 0, getProperty('yellowBG.x') + getProperty('yellowBG.height') + 50)
      setTextSize('txtTrackdeco', 28)
      setTextAlignment('txtTrackdeco', 'CENTER')
      setProperty('txtTrackdeco.color', getColorFromHex('0xFFe55777'))
      screenCenter('txtTrackdeco', 'X')
      
      
      addText('txtTrackdeco')
      addText('txtWeekTitle')
      
      for k,v in pairs(weekStuff) do
        local bannerCool = v.banner
        if menuVars.weeks[k] == 'weekquestionmark' then
          bannerCool = 'masterweekquestion'
        end
        makeSpr('weekBanner'..k, 'weekBanners/'..bannerCool, 0, getProperty('yellowBG.y'))
        screenCenter('weekBanner'..k, 'X')
        setProperty('weekBanner'..k..'.alpha', 0)
        if k == menuVars.curSelected then
          setProperty('weekBanner'..k..'.alpha', 1)
        end
        add('weekBanner'..k)
      end
      menuVars.changeSelection(changeSelectThing);
      ----debugPrint('yay')
      beenThere['main'] = true
    end
    --add your own menu here if you'd like
  }
  ----------debugPrint('set that up that')
  if menuStuff[menu] == nil then
    ----------debugPrint('OH NO MENU DOESNT EXIST NOOOO')
    return;
  end
  if not backwards then
    menuNum = menuNum + 1
    prevMenus[menuNum] = menu
  end
  
  ----------debugPrint('gonna do the stuff')
  local doShit = function()
  ----------debugPrint('yay')
    clearMenuObjs()
    _G['menu'] = menu --weird ass
    menuStuff[menu]()
    menuVars.hasSelected = false;
    stopUpdates = false
    ------------debugPrint(prevMenus)
    ------------debugPrint(menuNum)
    --------------debugPrint(menuVars)
  end
  if not skipTrans then
    trans(false, doShit)
  else
    if _G['menu'] == 'freeplay' then
      makeBG('coolBg', 0, 0, tostring(getProperty('bg.color')), menuVars.bg)
      setProperty('coolBg.alpha', 0)
      add('coolBg')
      ezTimer('killother', 0.1, doShit)
      doTweenAlpha('whatheeck', 'coolBg', 1, 0.1)
      doTweenColor('wharthta', 'coolBg', colors['other'], 0.1)
    else
      doShit()
    end
  end
end
function getScore(song)
  return runHaxeCode([[
    return Highscore.getScore(']]..song..[[');
  ]])
end
function trans(transin, callback) --trans rights!!!
  makeSpr('transition', 'transition', -2146)
  setProperty('transition.antialiasing', false)
  addLuaSprite('transition', true)
  doTweenX('transotu', 'transition', -432.95, 0.5)
  ezTimer(nil, 0.5, function()
    if callback ~= nil then
      callback()
      setObjectOrder('transition', 9999)
    end
    doTweenX('transotu', 'transition', 1280, 0.5)
    ezTimer(nil, 0.5, function()
      removeLuaSprite('transition', true)
    end)
  end)
end
function indexOf(table, what)
  for k,v in pairs(table) do
    ------debugPrint(v..', '..what..', '..tostring(v == what))
    if v == what then
      return k;
    end
  end
  return nil;
end
function getFakeFramerate()
  local fakeFramerate = runHaxeCode[[
    return 60;
  ]]
  -- --debugPrint(fakeFramerate)
  return tonumber(fakeFramerate)
end
function getHaxeValue(value, requiredLibs)
  if requiredLibs ~= nil and #requiredLibs > 0 then
    for k,v in pairs(requiredLibs) do
      addHaxeLibrary(v)
    end
  end
  return runHaxeCode([[
    return ]]..value..[[;
  ]])
end
function onUpdate(elapsed)
  local coolUpdates = {}
  local skipTransBack = false
  coolUpdates['main'] = function() --what happens each frame in the menus
    if not menuVars.hasSelected then
      if keyJustPressed('right') then
        menuVars.changeSelection(1)
      elseif keyJustPressed('left') then
        menuVars.changeSelection(-1)
      elseif keyJustPressed('accept') then
        playSound('confirmMenu')
        menuVars.menuFlashed = false
        runTimer('flashMainItem', 0.06)
        bgFlashed = true
        bgColor = colors['main']
        bgFlashTime = 0.15
        bgFlashMenu = 'main'
        runTimer('flashBG', 0.15)
        for k,v in pairs(menuVars.selectionMenu) do
          if k ~= menuVars.curSelected then
            doTweenAlpha('bye'..v, 'icon_'..v, 0, 1.3)
          end
        end
        menuVars.hasSelected = true
        if menuVars.selectionMenu[menuVars.curSelected] ~= 'discord' then
          ezTimer(nil, 1.1, function()
            makeMenu(menuVars.selectionMenu[menuVars.curSelected])
          end)
        else
          menuVars.hasSelected = false
        end
      end
    end
  end
  coolUpdates['freeplaySelect'] = function()
    for k,v in pairs(menuVars.packs) do
      setProperty(v..'.x', menuVars.mainOffset + (1280*(k-1)) + 384)
      setPos(v..'_TEXT', getProperty(v..'.x') + getProperty(v..'.width')/2, getProperty(v..'.y'))
      setProperty(v..'_TEXT.alpha', getProperty(v..'.alpha'))
    end
    if not menuVars.hasSelected then
      if keyJustPressed('right') then
        menuVars.changeSelection(1)
      elseif keyJustPressed('left') then
        menuVars.changeSelection(-1)
      elseif keyJustPressed('accept') then
        menuVars.hasSelected = true
      end
    elseif not menuVars.actuallySelected then
      local inter = runHaxeCode('Std.int('..tostring(menuVars.mainOffset)..');');
      if inter-5 < menuVars.offsetPoint and inter+5 > menuVars.offsetPoint then
        playSound('confirmMenu')
        local theGuy = menuVars.packs[menuVars.curSelected]
        doTweenY('bye', theGuy, -100, 0.25, 'sineOut')
        doTweenAlpha('okDude', theGuy, 0, 0.10)
        ezTimer(nil, 0.25, function()
          cancelTween('bye')
          makeMenu('freeplay', true, false, {group = menuVars.curSelected, bg = menuVars.bg})
        end)
        menuVars.actuallySelected = true
      end
    end
    -- --------------debugPrint(menuVars.mainOffset)
    -- menuVars.mainOffset = menuVars.offsetPoint
    menuVars.mainOffset = runHaxeCode([[
      var elapsed = ]]..tostring(elapsed)..[[;
      var lerpVal = CoolUtil.boundTo(elapsed * 15, 0, 1);
      return FlxMath.lerp(]]..tostring(menuVars.mainOffset)..[[, ]]..menuVars.offsetPoint..[[, lerpVal);
    ]]);
  end
  coolUpdates['freeplay'] = function()
    skipTransBack = true
    if not menuVars.hasSelected then
      if keyJustPressed('right') or keyJustPressed('down') then
        menuVars.changeSelection(1)
      elseif keyJustPressed('left') or keyJustPressed('up') then
        menuVars.changeSelection(-1)
      elseif keyJustPressed('accept') then
        local daSong = menuVars.songs[menuVars.curSelected].chart
        if checkFileExists('data/'..daSong..'/'..daSong..'.json') then
          menuVars.hasSelected = true;
          save.set('globalGuys', {
            group = menuVars.group;
            curSelected = menuVars.curSelected,
            menu = 'freeplay'
          })
          if keyboardPressed('CONTROL') or daSong == 'enter-terminal' then
            enterSong(daSong);
          else
            makeMenu('charSelect', false, false, {song = daSong, group = menuVars.group, songNum = menuVars.curSelected})
          end
        end
      end
    end
  end
  coolUpdates['charSelect'] = function()
    if not menuVars.hasSelected then
      if keyboardJustPressed('RIGHT') then
        menuVars.changeSelection(1)
      elseif keyboardJustPressed('LEFT') then
        menuVars.changeSelection(-1)
      elseif keyboardJustPressed('DOWN') then
        menuVars.changeSelection(0, -1)
      elseif keyboardJustPressed('UP') then
        menuVars.changeSelection(0, 1)
      elseif keyJustPressed('accept') then
        local daSong = menuVars.song
        if checkFileExists('data/'..daSong..'/'..daSong..'.json') then
          menuVars.hasSelected = true;
          local cool = save.get('globalGuys')
          cool.char = getProperty('daPlayer.curCharacter')
          save.set('globalGuys', cool)
          enterSong(daSong);
        end
      end
      local singShit = {
        {'D', 'singLEFT'},
        {'F', 'singDOWN'},
        {'J', 'singUP'},
        {'K', 'singRIGHT'}
      }
      if stringEndsWith(getProperty('daPlayer.curCharacter'), '-playable') then
        singShit[1] = {'D', 'singRIGHT'}
        singShit[4] = {'K', 'singLEFT'}
      end
      
      for k,v in pairs(singShit) do
        if keyboardJustPressed(v[1]) then
          runHaxeCode([[
            if(game.modchartSprites.exists('daPlayer'))
            {
              game.modchartSprites.get('daPlayer').playAnim(']]..v[2]..[[', true);
            }
          ]])
          menuVars.singReset = 0.5;
        end
      end
    end
    if menuVars.singReset > 0 then
      menuVars.singReset = menuVars.singReset - elapsed
    elseif menuVars.singReset > -1 then
      runHaxeCode([[
        if(game.modchartSprites.exists('daPlayer'))
        {
          game.modchartSprites.get('daPlayer').dance();
        }
      ]])
      menuVars.singReset = -1;
    end
  end
  coolUpdates['story'] = function()
    menuVars.coolOffset = runHaxeCode([[
      var elapsed = ]]..tostring(elapsed)..[[;
      var lerpVal = CoolUtil.boundTo(elapsed * 25, 0, 1);
      return FlxMath.lerp(]]..tostring(menuVars.coolOffset)..[[, ]]..menuVars.offsetPoint..[[, lerpVal);
    ]])
    for k,v in pairs(menuVars.weeks) do
      setProperty('weekMenuItem'..k..'.x', (420 * (k-1)) + menuVars.coolOffset + 420)
    end
    if not menuVars.hasSelected then
      if keyJustPressed('right') then
        menuVars.changeSelection(1)
      elseif keyJustPressed('left') then
        menuVars.changeSelection(-1)
      elseif keyJustPressed('accept') then
        playSound('confirmMenu')
        save.set('globalGuys', {
          isStoryMode = true,
          menu = 'story',
          songList = menuVars.weekStuff[menuVars.curSelected].songs,
          songIndex = 1,
          daWeek = menuVars.curSelected-1
        })
        local daSong = menuVars.weekStuff[menuVars.curSelected].songs[1]
        if daSong:lower() == 'supernovae' then
          save.set('clickedJoke', true)
        elseif daSong:lower() == 'house' then
          save.set('cutsceneHandler', {
            song = 'house',
            cutscene = 'daveCutscene'
          })
          daSong = 'cutscene-handler'
        end
        ezTimer(nil, 1, function()
          flushSaveData(dofile('mods/'..currentModDirectory..'/saveData.lua'))
          enterSong(daSong);
        end)
        menuVars.hasSelected = true
      end
      if runHaxeCode[[ return FlxG.keys.anyJustPressed(game.debugKeysChart) ]] and not save.get'foundJoke' then
        makeLuaSprite('whitething')
        setObjectCamera('whitething', 'other')
        makeGraphic('whitething', 1280, 720, 'FFFFFF')
        setProperty('whitething.alpha', 0)
        addLuaSprite('whitething', true)
        doTweenAlpha('whitething', 'whitething', 1, 5.29)
        playSound('doom')
        ----debugPrint('timer shit')
        lowerMusicShit = true
        ezTimer('gotasdfhjsa', 5.29, function()
          save.set('foundJoke', true)
          makeMenu('story', false, true, {daWeek = 5})
          removeLuaSprite('whitething', true)
        end)
      end
    else
      local fakeFramerate = getFakeFramerate()
      flashingInt = flashingInt + 1
      local shit = math.fmod(flashingInt, fakeFramerate) >= math.floor(fakeFramerate / 2)
      setProperty('weekMenuItem'..menuVars.curSelected..'.color', getColorFromHex(shit and '0xFF33ffff' or 'FFFFFF'))
      --debugPrint(shit)
    end
  end
  if not stopUpdates then
    if coolUpdates[menu] then coolUpdates[menu]() end
    if not lowerMusicShit then
      runHaxeCode[[
        if (FlxG.sound.music.volume < 0.7)
    		{
    			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
    		}
      ]]
    else
      runHaxeCode[[
        FlxG.sound.music.volume -= FlxG.elapsed;
      ]]
    end
  end
  if keyboardJustPressed('BACKSPACE') and menuNum-1 == 0 and not menuVars.hasSelected then
    endSong()
  elseif keyboardJustPressed('BACKSPACE') and not menuVars.hasSelected then
    ------------debugPrint('pres')
    -- playSound('cancelMenu')
    stopUpdates = true
    makeMenu(prevMenus[menuNum-1], skipTransBack, true, {bg = menuVars.bg, group = tonumberNil(menuVars.group)-1, songNum = tonumberNil(menuVars.songNum)}) --to go back
    menuNum = menuNum - 1
  end
end
function tonumberNil(inp)
  if inp == nil then
    return 0
  end
  return inp
end
function enterSong(song)
  enteringSong = true
  loadSong(song, -1);
end
function makeBG(tag, x, y, color, bg)
  local selectedBG = bgs[getRandomInt(1, #bgs)]
  if bg ~= nil then selectedBG = bg end
  if selectedBG == nil then
    selectedBG = bgs[getRandomInt(1, #bgs)]
  end
  makeSpr(tag, 'backgrounds/'..selectedBG, x, y)
  daColor = colors[color];
  if daColor == nil then daColor = color end
  setProperty(tag..'.color', getColorFromHex(daColor))
  return selectedBG;
end
function onStartCountdown()
  setProperty('inCutscene', true) --stops charting mode from shitting and ghsdfklzghdfjklshgjkldf
  return Function_Stop;
end
function makeSpr(tag, img, x, y, isAnim, disablePrefix)
  local path = 'title/'..img
  if disablePrefix then
    path = img
  end
  if not isAnim then
    makeLuaSprite(tag, path, x, y)
  else
    makeAnimatedLuaSprite(tag, path, x, y)
  end
  setObjectCamera(tag, 'other')
end
function add(tag)
  addLuaSprite(tag, true)
  table.insert(menuObjects, tag)
end
function makeText(tag, text, width, x, y)
  makeLuaText(tag, text, width, x, y)
  setObjectCamera(tag, 'other')
end
function addText(tag)
  addLuaText(tag)
  table.insert(menuText, tag)
end
function clearMenuObjs()
  -- ----------debugPrint(menuObjects)
  for k,v in pairs(menuObjects) do
    removeLuaSprite(v, true)
    menuObjects[k] = nil
  end
    ----------debugPrint('cleared sprs')
  for k,v in pairs(menuText) do
    removeLuaText(v, true)
    menuText[k] = nil
  end
  for k,v in pairs(haxeStuffToRemove) do
    runHaxeCode([[
      game.modchartSprites.get(']]..v..[[').kill();
      game.modchartSprites.get(']]..v..[[').destroy();
      game.modchartSprites.remove(']]..v..[[');
    ]])
    haxeStuffToRemove[k] = nil
  end
  -- ----------debugPrint('cleared alphabets')
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
function setPos(tag, x, y)
  setProperty(tag..'.x', x)
  setProperty(tag..'.y', y)
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
flashingInt = 0
function onTimerCompleted(tag)
  if tag == 'goLoopShit' then
    
  end
  local tagShit = {
    ['goLoopShit'] = function()
      local keepGoing = runHaxeCode([[
        if(game.modchartSprites.exists('daPlayer'))
        {
          if(]]..tostring(not stringStartsWith(getProperty('daPlayer.animation.curAnim.name'), 'sing'))..[[)
          {
            game.modchartSprites.get('daPlayer').dance();
          }
        }
        return game.modchartSprites.exists('daPlayer');
      ]])
      ----------debugPrint('keepGoing: '..tostring(keepGoing))
      -- ----------debugPrint(not stringStartsWith(getProperty('daPlayer.animation.curAnim.name'), 'sing'))
      if keepGoing then
        runTimer('goLoopShit', 2.18)
      end
    end,
    ['flashMainItem'] = function()
      local spr = 'icon_'..menuVars.selectionMenu[menuVars.curSelected]
      if luaSpriteExists(spr) then
        setProperty(spr..'.visible', menuVars.menuFlashed)
        menuVars.menuFlashed = not menuVars.menuFlashed
        runTimer('flashMainItem', 0.06)
      end
    end,
    ['flashBG'] = function()
      if luaSpriteExists('bg') and menu == bgFlashMenu then
        bgFlashed = not bgFlashed
        local color = bgFlashed and bgColor or colors['selected']
        setProperty('bg.color', getColorFromHex(color))
        runTimer('flashBG', bgFlashTime)
      end
    end
  }
  if timers[tag] then
    timers[tag]()
    timers[tag] = nil
    if stringStartsWith(tag, 'blank_tags-') then
      timers.blankTags = tonumber(stringSplit(tag, '-')[2])
    end
  end
  if tagShit[tag] then
    tagShit[tag]()
  end
end