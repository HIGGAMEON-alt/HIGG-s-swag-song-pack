
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 700;
local yy = 600;
local xx2 = 1000;
local yy2 = 900;
local ofs = 100;
local ofs2 = 50;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreatePost()
    makeLuaSprite('bgg', 'finale/bgg', -600, -400);
	setScrollFactor('bgg', 0.8, 0.8);
	makeLuaSprite('dead', 'finale/dead', 800, -270);
	setScrollFactor('dead', 0.8, 0.8);
	makeLuaSprite('bg', 'finale/bg', -790, -530);
	setScrollFactor('bg', 1, 1);
	makeLuaSprite('splat', 'finale/splat', 370, 1200);
	makeLuaSprite('fore', 'finale/fore', -750, 160);
  setScrollFactor('fore', 1.1, 1.1);
  
	makeLuaSprite('dark', 'finale/dark', -720, -350);
	setScrollFactor('dark', 1.05, 1.05);

	makeLuaSprite('lamp', 'finale/lamp', 1190, -280);

	makeAnimatedLuaSprite('light', 'finale/light', -230, -100);
	setScrollFactor('light', 1.05, 1.05);
  addAnimationByPrefix('light','finale/light','light',24,true);
	setBlendMode('light','add')
	setBlendMode('dark','multiply')

	addLuaSprite('bgg', false);
	addLuaSprite('dead', false);
	addLuaSprite('bg', false)
	addLuaSprite('splat', true)
	addLuaSprite('lamp', false);
	addLuaSprite('fore', true);
	addLuaSprite('dark', true);
	addLuaSprite('light', true)

	scaleObject('bgg', 1.1, 1.1)
	scaleObject('dead', 1.1, 1.1)
	scaleObject('bg', 1.1, 1.1)
	scaleObject('lamp', 1.1, 1.1)
	scaleObject('fore', 1.1, 1.1)
  scaleObject('splat', 1.1, 1.1)
	scaleObject('dark', 1.1, 1.1)
	scaleObject('light', 1.1, 1.1)
end

function onEvent(n,v1,v2)
    if n == 'Finale Drop' then
        STAGE = runHaxeCode[[
      return [StageData.getStageFile('finale'), 'what'];
    ]][1]
    setProperty('dad.x', STAGE.opponent[1])
    setProperty('dad.y', STAGE.opponent[2])
    --[[setProperty('boyfriend.x', STAGE.boyfriend[1])
    setProperty('boyfriend.y', STAGE.boyfriend[2])]]
    onCreatePost()
	-- -- background shit
	end
    if n:lower() == 'change character' then
    addLuaScript('characters/'..v1)
    end
end

function onBeatHit()
if (curBeat % 4 == 0) then
	playAnim('light','finale/light',true)
	 end
end

function onUpdatePost(elapsed)
if mustHitSection == false then
setProperty('defaultCamZoom',0.6)
else
setProperty('defaultCamZoom',0.7)
end
end

function onUpdate()
    setProperty('gf.alpha', 0);
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
                triggerEvent('Camera Follow Pos',xx2-ofs2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

end