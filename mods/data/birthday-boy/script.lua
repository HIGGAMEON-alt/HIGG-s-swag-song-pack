function onCreate()
    makeLuaSprite('blackFuck','', -1500, -1500)
    makeGraphic('blackFuck', 5000, 5000, '000000')
    addLuaSprite('blackFuck', true)
    setScrollFactor('blackFuck',0,0)
    setObjectCamera('blackFuck','other')
    setProperty('gf.visible', false)
    --setProperty('skipCountdown', true)
end

function onCreatePost()
    setProperty('introSoundsSuffix', nil)
end

function onBeatHit()
if curBeat % 4 == 0 then
onSectionHit(curBeat / 4)
end
end

function onSectionHit(curSec)
if curSec == 4 then
doTweenAlpha('poop', 'blackFuck', 0, 1.5, 'elapsed')
end
end