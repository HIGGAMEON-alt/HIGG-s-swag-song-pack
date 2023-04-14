
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  470;
local yy =  250;
local xx2 = 820;
local yy2 = 250;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('sky', 'stageassets/polus/polus_custom_sky', -400, -400)
setScrollFactor('sky', 0.5, 0.5)
scaleObject('sky', 1.4, 1.4)
addLuaSprite('sky')

makeLuaSprite('rocks', 'stageassets/polus/polusrocks', -700, -300)
setScrollFactor('rocks', 0.6, 0.6)
addLuaSprite('rocks')

makeLuaSprite('hills', 'stageassets/polus/polusHills')
setScrollFactor('hills', 0.9, 0.9)
addLuaSprite('hills')

makeLuaSprite('warehouse', 'stageassets/polus/polus_custom_lab', 50, -400)
addLuaSprite('warehouse')

makeLuaSprite('floor', 'stageassets/polus/polus_custom_floor', -1350, 80)
addLuaSprite('floor')

makeAnimatedLuaSprite('snow', 'stageassets/polus/snow', -500, -400)
addAnimationByPrefix('snow', 'cum', 'cum', 24, true)
scaleObject('snow', 2, 2)
playAnim('snow', 'cum', true)
addLuaSprite('snow', true)

makeAnimatedLuaSprite('speaker', 'stageassets/polus/speakerlonely', 300, 185)
addAnimationByPrefix('speaker', 'bop', 'speakers lonely', 24, false)
if songName:lower() == 'sabotage' then
addLuaSprite('speaker')
playAnim('speaker', 'bop', false)
end
if songName:lower() == 'meltdown' then
setPropertyFromClass('GameOverSubstate', 'characterName', 'bfg-dead')
addLuaSprite('speaker')
playAnim('speaker', 'bop', false)
makeLuaSprite('bfdead', 'stageassets/polus/bfdead', 600, 525)
scaleObject('bfdead', 0.8, 0.8)
addLuaSprite('bfdead')

makeLuaSprite('crowd2', 'stageassets/polus/boppers_meltdown', -900, 150)
addAnimationByPrefix('crowd2', 'bop', 'BoppersMeltdown', 24, false)
setScrollFactor('crowd2', 1.5, 1.5)
addLuaSprite('crowd2', true)
end
end

function onBeatHit()
--[[if songName:lower() == 'sabotage' or songName:lower() == 'meltdown' then
playAnim('speaker', 'bop', false)
end
if songName:lower() == 'meltdown' then
playAnim('speaker', 'bop', false)
objectPlayAnim('crowd2', 'bop', false)
end]]
playAnim('crowd2', 'bop', true)
end

function onCountdownTick(tick)
if songName:lower() == 'sabotage' then
playAnim('speaker', 'bop', false)
end
if songName:lower() == 'meltdown' then
playAnim('speaker', 'bop', false)
--playAnim('crowd2', 'bop', false)
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
            setProperty('defaultCamZoom',0.75)
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

            setProperty('defaultCamZoom',0.75)
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

