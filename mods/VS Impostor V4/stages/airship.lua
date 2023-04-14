
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 700;
local yy = -2000;
local xx2 = 1634.05;
local yy2 = -54.3;
local ofs = 50;
local followchars = true;
local del = 0;
local del2 = 0;
local speed = 40;
function onCreate()
makeLuaSprite('sky', 'stageassets/airship/sky', -1404, -897.55)
setProperty('sky.scale.x', 1.5)
setProperty('sky.scale.y', 1.5)
setScrollFactor('sky', 0, 0)
addLuaSprite('sky')

makeLuaSprite('airshipskyflash', 'stageassets/airship/screamsky', 0, -200)
addAnimationByPrefix('airshipskyflash', 'bop', 'screamsky instance 1', 24, false)
setGraphicSize('airshipskyflash', getProperty('airshipskyflash.width') * 3)
setProperty('airshipskyflash.antialiasing', false)
addLuaSprite('airshipskyflash')
setProperty('airshipskyflash.alpha', 0.001)

makeLuaSprite('cloud1', 'stageassets/airship/farthestClouds', -1048.05, -142.2)
setScrollFactor('cloud1', 0.1, 0.1)
addLuaSprite('cloud1')
makeLuaSprite('cloud2', 'stageassets/airship/farthestClouds', getProperty('cloud1.x') -1048.05, -142.2)
setScrollFactor('cloud2', 0.1, 0.1)
addLuaSprite('cloud2')
doTweenX('cloud1', 'cloud1',  -1048.05 - getProperty('cloud1.width'), speed, 'elapsed')

makeLuaSprite('backcloud1', 'stageassets/airship/backClouds', -1162.4, 76.55)
setScrollFactor('backcloud1', 0.1, 0.1)
addLuaSprite('backcloud1')
makeLuaSprite('backcloud2', 'stageassets/airship/backClouds', getProperty('backcloud1.x') -1162.4 , 76.55)
setScrollFactor('backcloud2', 0.1, 0.1)
addLuaSprite('backcloud2')
doTweenX('backcloud1', 'backcloud1', -1162.4 - getProperty('backcloud1.width') -450, speed * 0.8, 'elapsed')

makeLuaSprite('airship', 'stageassets/airship/airship', 1114.75, -873.05)
setScrollFactor('airship', 0.25, 0.25)
addLuaSprite('airship')

makeAnimatedLuaSprite('fan', 'stageassets/ariship/airshipFan', 2285.4, 102)
addAnimationByPrefix('fan', 'idle', 'ala avion instance 1', 24, true)
setScrollFactor('fan', 0.26, 0.26)
addLuaSprite('fan')

--[[addLuaSprite('bigCloud', 'stageassets/ariship/bigCloud', 3507.15, -744.2)
setScrollFactor('bigCloud', 0.4, 0.4)
addLuaSprite('bigCloud')]]


makeLuaSprite('platform1', 'stageassets/airship/fgPlatform', -1454.2, 282.25)
addLuaSprite('platform1')
makeLuaSprite('platform2', 'stageassets/airship/fgPlatform', getProperty('platform1.x') -1454.2, 282.25)
addLuaSprite('platform2')
doTweenX('platform1', 'platform1', -1454.2 - getProperty('platform1.width') -450, speed * 0.05, 'elapsed')
end

function onCreatePost()
setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-running-death')
end

function e()
setProperty('backcloud1.x', -1162.4)
doTweenX('backcloud1', 'backcloud1', -1162.4 - getProperty('backcloud1.width'), speed * 0.8, 'elapsed')
end
function ea()
setProperty('cloud1.x', getProperty('cloud2.x') - 450)
doTweenX('cloud1', 'cloud1',  -1048.05 - getProperty('cloud1.width'), speed, 'elapsed')
end

function eaSports()
setProperty('platform1.x', -1454.2 -450)
doTweenX('platform1', 'platform1', -1454.2 - getProperty('platform1.width') - 450, speed * 0.05, 'elapsed')
end


function onUpdatePost()
    setProperty('cloud2.x', getProperty('cloud1.x') + getProperty('cloud2.width'))
    setProperty('backcloud2.x', getProperty('backcloud1.x') + getProperty('backcloud2.width'))
    setProperty('platform2.x', getProperty('platform1.x') + getProperty('platform2.width') - 450)
    if getProperty('backcloud1.x') == 0 -1162.4 - getProperty('backcloud1.width') then
    e()
    end
    if getProperty('cloud1.x') == 0 -1048.05 - getProperty('cloud1.width') then
    ea()
     end
    if getProperty('platform1.x') == 0 -1454.2 - getProperty('platform1.width') -450 then
    eaSports()
    end
end

function onUpdate()
    setProperty('airship.x', getProperty('airship.x') - getProperty('songLength') * 0.0000001)
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
    if curStep == 1 then
        setProperty('defaultCamZoom',0.3)
		followchars = true
        xx = 1634.05
        yy = -54.3
        xx2 = 1634.05
        yy2 = -54.3
    end
    if curBeat == 64 then
        setProperty('defaultCamZoom', 0.4)
        followchars = true
        xx = 800
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 96 then
        setProperty('defaultCamZoom', 0.6)
        followchars = true
        xx = 700
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 128 then
        setProperty('defaultCamZoom', 0.4)
        xx = 800
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 155 then
        setProperty('defaultCamZoom', 0.8)
        followchars = true
        xx = 450
        yy = 150
        xx2 = 450
        yy2 = 150
    end
    if curBeat == 160 then
        setProperty('defaultCamZoom', 0.4)
        followchars = true
        xx = 800
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 192 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 700
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 256 then
        setProperty('defaultCamZoom', 0.4)
        followchars = true
        xx = 800
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 288 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 700
        yy = 150
        xx2 = 1200
        yy2 = 150
    end
    if curBeat == 320 then
        setProperty('defaultCamZoom', 0.3)
        followchars = true
        xx = 1634.05
        yy = -54.3
        xx2 = 1634.05
        yy2 = -54.3
    end
    if curBeat == 384 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 700
        yy = 150
        xx2 = 1200
        yy2 = 150
    end

    
end