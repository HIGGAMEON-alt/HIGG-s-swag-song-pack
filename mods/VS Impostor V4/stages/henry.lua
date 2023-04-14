
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 700;
local yy = 550;
local xx2 = 1000;
local yy2 = 550;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;

local crowdSprites = {'Clow bop', 'RareBlin Bop', 'Tophat Member 1 bop', 'front guy bop'}

function onCreatePost()
makeLuaSprite('bg', 'stagehenry', -1600, -300)
addLuaSprite('bg')
if songName:lower() == 'reinforcements' and isStoryMode then
makeAnimatedLuaSprite('armedGuy', 'stageassets/herny/i_schee_u_enry', -800, -300)
addAnimationByPrefix('armedGuy', 'crash', 'rhm intro shadow', 16, false)
setProperty('armedGuy.alpha', 0.001)
end
--[[if songName:lower() == 'armed' then
for i=1,#crowdSprites do
makeAnimatedLuaSprite(crowdSprites[i], 'fat_ugly_bitches',  0, 0)
addLuaSprite(crowdSprites[i], true)
addAnimationByPrefix(crowdSprites[i], 'bop', crowdSprites[i], 24, false)
end
addAnimationByPrefix(crowdSprites[1], 'intro', crowdSprites[1]..' intro', 24, false)
addAnimationByPrefix(crowdSprites[2], 'intro', crowdSprites[2]..' Intro', 24, false)
addAnimationByPrefix(crowdSprites[3], 'intro', 'Tophat Member 1 into', 24, false)
addAnimationByPrefix(crowdSprites[4], 'intro', 'front guy intro bop', 24, false)
setProperty('Clow bop.x', -300)
setProperty('Clow bop.y', 600)

setProperty('Tophat Member 1 bop.x', 200)
setProperty('Tophat Member 1 bop.y', 600)

setProperty('front guy bop.x', 700)
setProperty('front guy bop.y', 600)

setProperty('RareBlin Bop.x', 1500)
setProperty('RareBlin Bop.y', 600)
end]]
end

function onBeatHit()
if curBeat % 2 == 0 then
--playAnim(crowdSprites[1], 'bop', true)
--playAnim(crowdSprites[2], 'bop', true)
playAnim(crowdSprites[3], 'bop', true)
playAnim(crowdSprites[4], 'bop', true)
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
            setProperty('defaultCamZoom',0.7)
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('mom.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('mom.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('mom.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('mom.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('mom.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('mom.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('mom.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('mom.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
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

