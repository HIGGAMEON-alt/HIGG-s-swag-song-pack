
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 2000;
local yy = 1050;
local xx2 = 2300;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('bg','stageassets/airship/cargo',0,0)
addLuaSprite('bg')

makeLuaSprite('cargoDark', '', -1000, -1000)
makeGraphic('cargoDark', 5000, 5000, '000000')
setScrollFactor('cargoDark', 0, 0)
addLuaSprite('cargoDark')
end

function onCreatePost()
setObjectOrder('dad', getObjectOrder('mom')+ 1)
setObjectOrder('boyfriend', getObjectOrder('mom') + 5)
setObjectOrder('cargoDark', getObjectOrder('boyfriend') + 5)
setProperty('camGame.zoom', getProperty('camGame.zoom') - 0.03)
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
            setProperty('defaultCamZoom',0.8)
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
    if curStep == 1 then
    doTweenZoom('cam','camGame',getProperty('defaultCamZoom'), 0.7, 'quadInOut')
    doTweenAlpha('cragoDark', 'cargoDark',0,1,'elapsed')
    end
    if curStep == 16 then
    cameraFlash('camGame', '000000', 0.55, true)
    end
    if curStep == 1168 then
    cameraFlash('camGame', 'FFFFFF', 0.55, true)
    end
    if curBeat >= 356 and curBeat < 420 then
		setProperty('defaultCamZoom',1.1)
        xx2 = 2750;
        yy2 = 1150;  
	end
    if curBeat == 420 then
		setProperty('defaultCamZoom',0.8)
        xx2 = 2300;
        yy2 = 1050;  
	end
    if curBeat >= 552 and curBeat < 556 then
		setProperty('defaultCamZoom',1.2)
        xx = 1650;
        yy = 1180;  
	end
    if curBeat == 556 then
        xx = 2000;
        yy = 1050;  
	end
    if curBeat == 847 then
    doTweenAlpha('camGameIn', 'camGame', 0, 0.8, 'elapsed')
    end
    if curBeat == 851 then
        doTweenAlpha('camGameIn', 'camGame', 1, 5, 'elapsed')
        setProperty('dad.visible', false)
        triggerEvent('change character')
        makeLuaSprite('stageback', 'iluminao omaga',900,400)
        addLuaSprite('stageback', true)
        makeLuaSprite('stagefront', 'iluminao omaga',900,400)
        addLuaSprite('stagefront')
        setProperty('stageback.alpha', 1)
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('timeTxt.alpha', 0)
        setProperty('timeBarBG.alpha', 0)
        setProperty('timeBar.alpha', 0)
        removeLuaSprite('bg')
        removeLuaSprite('cargoDark')
        triggerEvent('Change Character', 'BF', 'blackdk')
        triggerEvent('Change Character', 'BF', 'bf-defeat-normal')
        setBlendMode('stageback', 'ADD')
    end
    if curBeat == 916 then
        doTweenZoom('defeated', 'camGame', 0.4, 20, 'linear')
    end
    if curStep == 3920 then
    setProperty('boyfriend.visible', false)
    setProperty('mom.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('stageback.visible', false)
    setProperty('stagefront.visible', false)
    cameraFlash('camGame', 'FF0000', 0.3, true)
    end
end

