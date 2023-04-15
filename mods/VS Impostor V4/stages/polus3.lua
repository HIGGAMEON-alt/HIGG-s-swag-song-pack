--[[
NOTE:Shaders were indeed originally included in this port but
due to removing shaders for the sake of performance I will remove the shader code
]]
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 1760;
local yy = 380;
local xx2 = 1900;
local yy2 = 435;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeAnimatedLuaSprite('lava', 'stageassets/polus/wallBP', -400, -650)
addAnimationByPrefix('lava', 'bop', 'Back wall and lava', 24, true)
addLuaSprite('lava', false)
setProperty('lava.antialiasing', false)

makeLuaSprite('ground', 'stageassets/polus/platform', 1050, 650)
addLuaSprite('ground')

makeAnimatedLuaSprite('bubbles', 'stageassets/polus/bubbles', 800, 850)
addAnimationByPrefix('bubbles', 'bop', 'Lava Bubbles', 24, true)
setProperty('bubbles.antialiasing', false)
addLuaSprite('bubbles', true)
end

function onCreatePost()
    setBlendMode('lava', 'ADD')
makeLuaSprite('lavaoverlay', 'stageassets/polus/overlaythjing', 1000, -50)
setProperty('lavaoverlay.scale.x', 1.5)
setProperty('lavaoverlay.scale.y', 1.5)
setProperty('lavaoverlay.alpha', 0.7)
setBlendMode('lavaoverlay', 'ADD')
addLuaSprite('lavaoverlay', true)
end

function onUpdatePost()
    setProperty("gf.alpha", 0)
    if mustHitSection then
        setProperty('defaultCamZoom',0.7)
    else
        setProperty('defaultCamZoom',0.6)
    end

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
        elseif mustHitSection then
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