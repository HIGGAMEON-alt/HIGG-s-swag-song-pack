function onCreatePost()
changeCursorSprite("mouse cursors/Cursor normal")
setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);

makeLuaSprite('mouseHitBoxGame', '', 0, 0)
addLuaSprite('mouseHitBoxGame', true)
setProperty('mouseHitBoxGame.antialiasing', false);
scaleLuaSprite('mouseHitBoxGame', 2, 2);
setObjectCamera('mouseHitBoxGame', 'camGame')
setProperty('mouseHitBoxGame.visible', false)
makeLuaSprite('hammer', 'bg/hammer', 350,750)
addLuaSprite('hammer', false)
updateHitbox('hammer')
mousePressedOnObject = false
mouseOnObject = nil
hammerY = getProperty('hammer.y')
speed = 1
HammerDrop = false
end

function onUpdate()
mouseoffsetX = getProperty('defaultCamZoom') + getMouseX('game') - 660 + getProperty('camFollowPos.x') 
mouseoffsetY = getProperty('defaultCamZoom') + getMouseY('game') - 380 + getProperty('camFollowPos.y') 
makeGraphic('mouseHitBoxGame', 40, 40, 'ffffff')
setProperty('mouseHitBoxGame.x', mouseoffsetX)
setProperty('mouseHitBoxGame.y', mouseoffsetY)
if checkCollisionOverlaping('mouseHitBoxGame', 'hammer') then
changeCursorSprite("mouse cursors/Cursor grabbable")
end
if checkCollisionOverlaping('mouseHitBoxGame', 'hammer') and mousePressed('left') then
mouseOnObject = 'hammer'
setObjectOrder('hammer', getObjectOrder('dadGroup') + 2)
mousePressedOnObject = true
end 
if mousePressedOnObject == true then
changeCursorSprite("mouse cursors/Cursor grab")
setProperty(mouseOnObject..'.x', getProperty('mouseHitBoxGame.x') - 5)
setProperty(mouseOnObject..'.y', getProperty('mouseHitBoxGame.y') - 5)
setProperty('hammer.angle', 100)
speed = 1
end
if mouseReleased('left') then
mousePressedOnObject = false
mouseOnObject = nil
changeCursorSprite("mouse cursors/Cursor normal")
end
if mouseOnObject == nil and getProperty('hammer.y') < hammerY then
hammerY = 750
speed = speed * 1.002
setProperty('hammer.y', getProperty('hammer.y') * speed)
doTweenAngle('hammerBack', 'hammer', 0, speed * 0.1, 'elapsed')
HammerDrop = true
end
if HammerDrop == true and getProperty('hammer.y') >= hammerY then
triggerEvent('Screen Shake', 5, 5)
HammerDrop = false
end
if checkCollisionOverlaping('mouseHitBoxGame', 'hammer') == false then
changeCursorSprite("mouse cursors/Cursor normal")
end
end

function checkCollisionOverlaping(obj1, obj2)
updateHitbox(obj1)
updateHitbox(obj2)
if getProperty(''..obj1..'.x') - getProperty(''..obj1..'.offset.x') >= getProperty(''..obj2..'.x') + getProperty(''..obj2..'.offset.x') and getProperty(''..obj1..'.x') + getProperty(''..obj1..'.frameWidth') - getProperty(''..obj1..'.offset.x') <= getProperty(''..obj2..'.x') + getProperty(''..obj2..'.offset.x') + getProperty(''..obj2..'.frameWidth') and getProperty(''..obj1..'.y') - getProperty(''..obj1..'.offset.y') >= getProperty(''..obj2..'.y') - getProperty(''..obj2..'.offset.y') and getProperty(''..obj1..'.y') - getProperty(''..obj1..'.offset.y') + getProperty(''..obj1..'.frameHeight') <= getProperty(''..obj2..'.y') - getProperty(''..obj2..'.offset.y') + getProperty(''..obj2..'.frameHeight') then
return true
else
return false
end
end