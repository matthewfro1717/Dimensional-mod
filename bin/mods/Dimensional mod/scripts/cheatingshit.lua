songToGoTo = {
  ['vs-dave-rap'] = 'vs-dave-rap-two',
  ['supernovae'] = 'scaryCheatingCutscene',
  ['glitch'] = 'kabunga',
  ['unfairness'] = 'scaryCheatingCutscene'
}
function onUpdatePost()
  if songToGoTo[songName:lower()] ~= nil then --i spent WAY too fucking long on this i dont even know why it started happening
    if runHaxeCode[[ return FlxG.keys.anyJustPressed(game.debugKeysChart) && !game.endingSong && !game.inCutscene; ]] then
      if songToGoTo[songName:lower()] then
        -- runHaxeCode[[
        --   game.debugKeysChart = game.debugKeysCharacter; //makes it so psych engine doesnt enter chartingmode
        -- ]]
        loadSong(songToGoTo[songName:lower()], -1)
      end
    end
  end
end