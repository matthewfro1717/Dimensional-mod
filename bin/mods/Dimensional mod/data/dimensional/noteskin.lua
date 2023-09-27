function onUpdatePost()
     for i=0,4,1 do
      setPropertyFromGroup('opponentStrums', i, 'texture', 'BArrows')
      setPropertyFromGroup('opponentStrums', i, 'antialiasing', false)
    end
end
function onStartCountdown()
  setProperty('introSoundsSuffix', '-bambi')
  for i = 0, getProperty('unspawnNotes.length')-1 do
  if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
    setPropertyFromGroup('unspawnNotes', i, 'texture', 'BArrows'); --Change texture
    setPropertyFromGroup('unspawnNotes', i, 'antialiasing', false)
  end
end
end
