
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 1200;
local yy = 800;
local xx2 = 1400;
local yy2 = 800;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
makeLuaSprite('wall', 'stageassets/chef/Back Wall Kitchen',0,0)
setGraphicSize('wall', getProperty('wall.width') * 0.8)
addLuaSprite('wall')

makeLuaSprite('floor', 'stageassets/chef/chef Floor',-850, 900)
addLuaSprite('floor')
setGraphicSize('floor', getProperty('floor.width') * 1.3)

makeLuaSprite('backshit', 'stageassets/chef/Back Table Kitchen', -50, 210)
setGraphicSize('backshit', getProperty('backshit.width') * 0.8)
addLuaSprite('backshit')

makeLuaSprite('oven', 'stageassets/chef/oven', 1600, 400)
setGraphicSize('oven', getProperty('oven.width') * 0.8)
addLuaSprite('oven')

addAnimatedChar('grey', 1000, 525, 0.8)
addAnimatedChar('saster', 1300, 525, 1.2)

makeLuaSprite('frontable', 'stageassets/chef/Kitchen Counter', 800, 700)
addLuaSprite('frontable')

makeLuaSprite('chefBlueLight', 'stageassets/chef/bluelight', -300, 0)
addLuaSprite('chefBlueLight', true)
setBlendMode('chefBlueLight', 'ADD')

makeLuaSprite('lastAsset', 'stageassets/chef/black_overhead_shadow', -300, 0)
addLuaSprite('lastAsset')
end

function addAnimatedChar(n,x,y,scale)
makeAnimatedLuaSprite(n, 'stageassets/chef/Boppers', x,y)
addAnimationByPrefix(n,'bop',n,24,false)
addLuaSprite(n)
if scale == nil then
else
setGraphicSize(n, getProperty(n..'.width') * scale)
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

	if curStep >= 171 and curStep < 176 then
		setProperty('defaultCamZoom',1)
	end

    if curBeat == 44 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 112 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 113 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 114 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 115 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat == 116 then
		setProperty('defaultCamZoom',0.8)
		xx = 1200;
		yy = 800;
	end

	if curStep == 206 or curStep == 207 then
		setProperty('defaultCamZoom',1)
	end

	if curStep >= 399 and curStep < 404 then
		setProperty('defaultCamZoom',1)
	end

	if curStep == 404 then
		setProperty('defaultCamZoom',0.8)
	end

	if curStep == 1172 then
		setProperty('defaultCamZoom', 0.8)
	end

	if curStep >= 1164 and curStep < 1172 then
		setProperty('defaultCamZoom',1)
	end

	if curStep == 1172 then
		setProperty('defaultCamZoom',0.8)
	end

	if curBeat == 304 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 305 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 306 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 307 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat == 308 then
		setProperty('defaultCamZoom',0.8)
		xx = 1200;
		yy = 800;
	end

	if curBeat == 320 then
		setProperty('defaultCamZoom',0.9)
		xx = 1180;
		yy = 820;
	end

	if curBeat == 321 then
		setProperty('defaultCamZoom',1)
		xx = 1160;
		yy = 840;
	end

	if curBeat == 322 then
		setProperty('defaultCamZoom',1.1)
		xx = 1140;
		yy = 860;
	end

	if curBeat == 323 then
		setProperty('defaultCamZoom',1.2)
		xx = 1120;
		yy = 880;
	end

	if curBeat >= 324 then
		setProperty('defaultCamZoom',0.7)
		followchars = false
		triggerEvent('Camera Follow Pos', 1300, 700)
	end
    
end

function onBeatHit()
if curBeat % 2 == 0 then
playAnim('grey', 'bop', false)
playAnim('saster', 'bop', false)
end
end