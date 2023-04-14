
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  1000;
local yy =  1050;
local xx2 = 1400;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
local XOffset = -50
bopList = {'peopleloggo', 'nickt', 'toogusorange', 'toogusblue', 'thebackground', 'crowd'}
function onCreate()
makeLuaSprite('bg', 'stageassets/attack/monotoneback', 0 + XOffset, 0)
addLuaSprite('bg')

makeAnimatedLuaSprite('peopleloggo', 'stageassets/attack/crowd', 850 + XOffset, 850)
addAnimationByPrefix('peopleloggo', 'bop', 'tess n gus fring instance 1', 24, false)
addLuaSprite('peopleloggo')
playAnim('peopleloggo', 'bop', true)

makeLuaSprite('bg2', 'stageassets/attack/fg', 0 + XOffset, 0)
addLuaSprite('bg2')

makeAnimatedLuaSprite('nickt', 'stageassets/attack/nick t', 600 + XOffset, 700)
addAnimationByPrefix('nickt', 'bop', 'nick t idle', 24, false)
addLuaSprite('nickt')

makeAnimatedLuaSprite('nicktmvp', 'stageassets/attack/nick t', 600 + XOffset, 700)
addAnimationByPrefix('nicktmvp', 'bop', 'nick t animation', 24, false)
addLuaSprite('nicktmvp')
setProperty('nicktmvp.visible', false)

makeAnimatedLuaSprite('toogusorange', 'stageassets/attack/offbi', 1250 + XOffset, 625)
addAnimationByPrefix('toogusorange', 'bop', 'offbi', 24, false)
addLuaSprite('toogusorange')

makeAnimatedLuaSprite('toogusblue', 'stageassets/attack/orbyy', 850 + XOffset, 665)
addAnimationByPrefix('toogusblue', 'bop', 'orbyy', 24, false)
addLuaSprite('toogusblue')

makeAnimatedLuaSprite('toogusblue2', 'stageassets/attack/orbyy', 850 + XOffset, 665)
addAnimationByPrefix('toogusblue2', 'bop', 'shutup', 24, false)
addLuaSprite('toogusblue2')
setProperty('toogusblue2.visible', false)

makeAnimatedLuaSprite('thebackground', 'stageassets/attack/loggoattack', 950 + XOffset, 775)
addAnimationByPrefix('thebackground', 'bop', 'loggfriend', 24, false)
addLuaSprite('thebackground')

makeAnimatedLuaSprite('crowd', 'stageassets/attack/cooper', 1950 + XOffset, 750)
addAnimationByPrefix('crowd', 'bop', 'bg seat 1 instance 1', 24, false)
addLuaSprite('crowd')

makeLuaSprite('bg3', 'stageassets/attack/backlights', 0 + XOffset, -60)
addLuaSprite('bg3')
setBlendMode('bg3', 'ADD')

makeLuaSprite('bg4', 'stageassets/attack/lamp', 0 + XOffset, 0)
addLuaSprite('bg4')
end

function onCreatePost()
setObjectOrder('boyfriend', getObjectOrder('mom') + 2)
setObjectOrder('gf', getObjectOrder('dad') - 2)
end

function onBeatHit()
if curBeat % 2 == 0 then
for i=1,#bopList do
playAnim(bopList[i],'bop', true)
end
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
    if curBeat == 64 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 80 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 95 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1000
        yy = 900
        xx2 = 1000
        yy2 = 900
    end
    if curBeat == 99 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 1000
        yy = 1050
        xx2 = 1400  
        yy2 = 1050
    end
    if curBeat == 196 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 229 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 276 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 292 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 1000
        yy = 1050
        xx2 = 1400  
        yy2 = 1050
    end
    if curBeat == 324 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 355 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1000
        yy = 900
        xx2 = 1000
        yy2 = 900
    end
    if curBeat == 360 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    
    
end

