
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 300;
local yy = 500;
local xx2 = 700;
local yy2 = 500;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('element8','stageassets/airship/newAirship/fartingSky', -1468, -995)
setScrollFactor('element8',0.3,0.3)
addLuaSprite('element8')

makeLuaSprite('element5','stageassets/airship/newAirship/backSkyyellow', -1125, 284)
setScrollFactor('element5',0.4, 0.7)
addLuaSprite('element5')

makeLuaSprite('element6','stageassets/airship/newAirship/yellow cloud 3', 1330, 283)
setScrollFactor('element6',0.5, 0.8)
addLuaSprite('element6')

makeLuaSprite('element7','stageassets/airship/newAirship/yellow could 2', -837, 304)
setScrollFactor('element7',0.6, 0.9)
addLuaSprite('element7')

makeLuaSprite('element2','stageassets/airship/newAirship/window', -1387, -1231)
addLuaSprite('element2')

makeLuaSprite('element4','stageassets/airship/newAirship/cloudYellow 1', -1541, 242)
setScrollFactor('element4',0.8, 0.8)
addLuaSprite('element4')

makeLuaSprite('element1','stageassets/airship/newAirship/backDlowFloor', -642, 325)
setScrollFactor('element1',0.9,1)
addLuaSprite('element1')

makeLuaSprite('element0','stageassets/airship/newAirship/DlowFloor', -2440, 336)
addLuaSprite('element0')

makeLuaSprite('element3','stageassets/airship/newAirship/glowYellow', -1113, -1009)
addLuaSprite('element3')
setBlendMode('element3', 'ADD')

if songName:lower() == 'dlow' or songName:lower() == 'mando' then
makeLuaSprite('henryTeleporter', 'stageassets/airship/newAirship/Teleporter', 998, 620)
addLuaSprite('henryTeleporter')
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
            setProperty('defaultCamZoom',0.6)
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

            setProperty('defaultCamZoom',0.6)
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

