function onUpdate()
    --setProperty('camGame.angle', getProperty('camGame.angle') + 5)
if curStep == 128 then
makeLuaSprite('sfxjumpscare', 'BOOM', 0, 0)
addLuaSprite('sfxjumpscare')
setObjectCamera('sfxjumpscare', 'camHUD')
setGraphicSize('sfxjumpscare', screenWidth, screenHeight)
--screenCenter('sfx jumpscare!!!', 'xy')
doTweenAlpha('BOO!!', 'sfxjumpscare', 0, 1, 'quadOut')
end
end

--[[function onTweenCompleted(tag)
if tag == 'BOO!!' then
removeLuaSprite('sfx jumpscare!!!')
end
end]]
