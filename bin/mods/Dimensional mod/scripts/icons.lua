local bounce = 1.05
local bounce2 = 1.15

function onUpdatePost()
    setProperty('iconP1.scale.y', (getProperty('iconP1.scale.y') - 1) / -bounce2 + 1)
    setProperty('iconP2.scale.y', (getProperty('iconP2.scale.y') - 1) / -bounce + 1)
    setProperty('iconP1.origin.y', 0)
    setProperty('iconP2.origin.y', 0)
    
if getProperty('health') <= 0.375 then
    bounce2 = 0.9
    bounce = 1.15
end
if getProperty('health') >= 1.625 then
    bounce2 = 1.15
    bounce = 0.9
end
end

function onBeatHit()
   setProperty('iconP1.scale.x', bounce2*1.2)
   setProperty('iconP2.scale.x', bounce*1.2)
end