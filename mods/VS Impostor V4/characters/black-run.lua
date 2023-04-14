local step = 0
function onCreatePost()
makeAnimatedLuaSprite('blacklegs', 'characters/blacklegs', 0, 0)
addAnimationByIndices('blacklegs', 'DanceLeft', 'legs', '0,1,2,3,4,5,6,7,8', 24)
addAnimationByIndices('blacklegs', 'DanceRight', 'legs', '9,10,11,12,13,14,15', 24)
addLuaSprite('blacklegs')
setObjectOrder('blacklegs', getObjectOrder('dadGroup') -1)
end

function onUpdate()
if dadName == 'black-run' then
setProperty('blacklegs.x', getProperty('dad.x') + 10)
setProperty('blacklegs.y', getProperty('dad.y') +120)
else
setProperty('blacklegs.x', getProperty('dad.x') - 100)
setProperty('blacklegs.y', getProperty('dad.y') + 550)
end
end

function onSectionHit()
setObjectOrder('blacklegs', getObjectOrder('dadGroup') -1)
end

function onBeatHit()
if step == 0 then
objectPlayAnimation('blacklegs', 'DanceLeft')
step = 1
end
if step == 1 then
objectPlayAnimation('blacklegs', 'DanceRight')
step = 0
end
end