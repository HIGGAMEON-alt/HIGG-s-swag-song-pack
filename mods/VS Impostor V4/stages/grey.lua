
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0
local xx = 1300;
local yy = 700;
local xx2 = 1800;
local yy2 = 700;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('bg', 'stageassets/airship/graybg', 0, 0)
addLuaSprite('bg')

makeAnimatedLuaSprite('theground!!!', 'stageassets/airship/grayglowy', 1930, 400)
addAnimationByPrefix('theground!!!', 'bop', 'jar??', 24, true)
addLuaSprite('theground!!!')
playAnim('theground!!!', 'bop', true)

makeAnimatedLuaSprite('crowd', 'stageassets/airship/grayblack', 240, 350)
addAnimationByPrefix('crowd', 'bop', 'whoisthismf', 24, false)

makeLuaSprite('lightoverlay', 'stageassets/airship/grayfg', 0, 0)
addLuaSprite('lightoverlay', true)

makeLuaSprite('lightoverlayM', 'stageassets/airship/graymultiply', 0, 0)
addLuaSprite('lightoverlayM', true)
setBlendMode('lightoverlayM', 'MULTIPLY')

makeLuaSprite('lightoverlayM2', 'stageassets/airship/grayoverlay', 0, 0)
addLuaSprite('lightoverlayM2', true)
setProperty('lightoverlayM2.alpha', 0.4)
setBlendMode('lightoverlayM2', 'MULTIPLY')
end

function onBeatHit()
if curBeat % 2 == 0 then
playAnim('crowd', 'bop', false)
end
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
            setProperty('defaultCamZoom',0.8)
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

            setProperty('defaultCamZoom',0.8)
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

