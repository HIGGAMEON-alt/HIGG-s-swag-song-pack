
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  1600;
local yy =  1300;
local xx2 = 1800;
local yy2 = 1300;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
local x = 400
local y = 200
function onCreate()
makeLuaSprite('bg', 'stageassets/polus/newsky', x, y)
setGraphicSize('bg', getProperty('bg.width') * 0.75)
addLuaSprite('bg')

makeLuaSprite('lava', 'stageassets/polus/newlava',x,y)
setGraphicSize('lava', getProperty('lava.width') * 0.75)
setBlendMode('lava', 'ADD')
addLuaSprite('lava')

makeLuaSprite('overlay', 'stageassets/polus/newoverlay',x,y)
setBlendMode('overlay', 'ADD')
addLuaSprite('overlay')
setGraphicSize('overlay', getProperty('overlay.width') * 0.75)
setProperty('overlay.alpha', 0.44)

makeLuaSprite('overlay2', 'stageassets/polus/newoverlay',x,y)
setBlendMode('overlay2', 'ADD')
addLuaSprite('overlay2', true)
setGraphicSize('overlay2', getProperty('overlay2.width') * 0.75)
setProperty('overlay2.alpha', 0.21)


makeLuaSprite('cloud', 'stageassets/polus/newcloud', x, y)
addLuaSprite('cloud')
setGraphicSize('cloud', getProperty('cloud.width') * 0.75)
setProperty('cloud.alpha', 0.59)

makeLuaSprite('rocks', 'stageassets/polus/newrocks', x, y)
addLuaSprite('rocks')
setGraphicSize('rocks', getProperty('rocks.width') * 0.75)
setProperty('rocks.alpha', 0.49)

makeLuaSprite('backwall', 'stageassets/polus/newbackwall', x, y)
addLuaSprite('backwall')
setGraphicSize('backwall', getProperty('backwall.width') * 0.75)

makeAnimatedLuaSprite('snowBack', 'stageassets/polus/snowback',x + 200, 600)
addAnimationByPrefix('snowBack', 'cum', 'Snow group instance 1', 24, true)
setProperty('snowBack.alpha', 0.53)
addLuaSprite('snowBack')
setGraphicSize('snowBack', getProperty('snowBack.width') * 2)
playAnim('snowBack', 'anim', false)

makeLuaSprite('stage', 'stageassets/polus/newstage', x, y)
setGraphicSize('stage', getProperty('stage.width') * 0.75)
addLuaSprite('stage')

makeAnimatedLuaSprite('snowFront', 'stageassets/polus/snowfront',x + 200, 800)
addAnimationByPrefix('snowFront', 'anim', 'snow fall front instance', 24, true)
setProperty('snowFront.alpha', 0.37)
setGraphicSize('snowFront', getProperty('snowFront.width') * 2)
addLuaSprite('snowFront', true)
playAnim('snowFront', 'anim', true)
end




function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.7)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',0.7)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end

