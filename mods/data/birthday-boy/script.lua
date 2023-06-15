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
    camZoom = getProperty('defaultCamZoom')
    setProperty('introSoundsSuffix', nil)
    triggerEvent('Camera Follow Pos', 1035.5, 126.5)
    setProperty('camGame.zoom', 1.37)
    setProperty('defaultCamZoom', 1.37)
end

function onBeatHit()
if curBeat % 4 == 0 then
onSectionHit(curBeat / 4)
end
end

function onSectionHit(curSec)
if curSec == 4 then
doTweenAlpha('poop', 'blackFuck', 0, 1.5, 'elapsed')
cameraSpeed = getProperty('cameraSpeed')
setProperty('cameraSpeed', 0.9)
setProperty('defaultCamZoom', camZoom)
doTweenZoom('Camera Zoom Out', 'camGame', getProperty('defaultCamZoom'), 3.5, 'circInOut')
triggerEvent('Camera Follow Pos', '', '')
end
if curSec == 6 then
setProperty('cameraSpeed', cameraSpeed)
close(true)
end
end