function opponentNoteHit(id, direction, noteType, isSustainNote)
setProperty('health', getProperty('health') - 0.7 * ((getProperty('health')/22))/3)
end

function noteMissPress(direction)
setProperty('health', getProperty('health') + 0.023)
end