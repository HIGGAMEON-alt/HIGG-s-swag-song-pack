
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  500;
local yy =  475;
local xx2 = 900;
local yy2 = 475;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('bg', 'mirabg', -1600, 50)
setGraphicSize('bg', getProperty('bg.width') * 1.06)
addLuaSprite('bg')

makeLuaSprite('fg', 'mirafg', -1600, 50)
setGraphicSize('fg', getProperty('fg.width') * 1.06)
addLuaSprite('fg')

if songName:lower() == 'sussus toogus' then

end

if songName:lower() == 'lights down' then
makeAnimatedLuaSprite('toogusblue', 'mira/mirascaredmates', 1200, 250)
addAnimationByPrefix('toogusblue','bop', 'blue', 24, false)
addAnimationByPrefix('toogusblue','bop2', '1body', 24, false)
addLuaSprite('toogusblue')
playAnim('toogusblue', 'bop')
end

makeLuaSprite('tbl', -1600, 500, 'table_bg')
addLuaSprite('tbl')
setGraphicSize('tbl', getProperty('tbl.width') * 1.06)

if songName:lower() == 'lights down' then

end
end

function onEvent(n)
if n:lower() == 'lights out' then
    setProperty('bg.alpha', 0.001)
    setProperty('fg.alpha', 0.001)
    setProperty('gf.visible', false)
    cameraFlash('camGame', 'FFFFFF', 0.35, true)
    if boyfriendName == 'bf' then
    triggerEvent('Change Character', '0', 'whitebf')
    end
    if dadName == 'impostor3' then
    triggerEvent('Change Character', '1', 'whitegreen')
    end
end
if n:lower() == 'lights on' then
    setProperty('bg.alpha', 1)
    setProperty('fg.alpha', 1)
    setProperty('gf.visible', true)
    cameraFlash('camGame', '000000', 0.35, true)
    if boyfriendName == 'whitebf' then
    triggerEvent('Change Character', '0', 'bf')
    end
    if dadName == 'whitegreen' then
    triggerEvent('Change Character', '1', 'impostor3')
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
            setProperty('defaultCamZoom',0.9)
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

            setProperty('defaultCamZoom',0.9)
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

