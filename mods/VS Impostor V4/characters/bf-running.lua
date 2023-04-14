local step = 0
function onCreatePost()
makeAnimatedLuaSprite('bflegs', 'characters/bf_legs', 0, 0)
addAnimationByIndices('bflegs', 'DanceLeft', 'run legs', '0,1,2,3,4,5,6,7,8,9', 24)
addAnimationByIndices('bflegs', 'DanceRight', 'run legs', '10,11,12,13,14,15,16,17,18,19', 24)
addLuaSprite('bflegs')
setObjectOrder('bflegs', getObjectOrder('boyfriendGroup') -1)
end

function onUpdate()
setProperty('bflegs.x', getProperty('boyfriend.x') - 80)
setProperty('bflegs.y', getProperty('boyfriend.y') + 180)
end

function onSectionHit()
setObjectOrder('bflegs', getObjectOrder('boyfriendGroup') -1)
end

function onBeatHit()
if step == 0 then
objectPlayAnimation('bflegs', 'DanceLeft')
step = 1
end
if step == 1 then
objectPlayAnimation('bflegs', 'DanceRight')
step = 0
end
end