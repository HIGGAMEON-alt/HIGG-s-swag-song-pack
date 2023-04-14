
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 500;
local yy = 600;
local xx2 = 700;
local yy2 = 700;
local ofs = 100;
local followchars = true;
local del = 0;
local del2 = 0;
local ofs2 = 0
local finaleDrop = false
function onCreate()
makeLuaSprite('stageback', 'iluminao omaga',-600,400)
addLuaSprite('stageback')
makeLuaSprite('stagefront', 'iluminao omaga',-600,400)
addLuaSprite('stagefront', true)
setProperty('stagefront.alpha', 0.7)
precacheImage('characters/blackparasite')
precacheImage('finale/bgg');
precacheImage('finale/dead');
precacheImage('finale/bg')
precacheImage('finale/splat')
precacheImage('finale/lamp');
precacheImage('finale/fore');
precacheImage('finale/dark');

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
makeLuaSprite('blackParasiteLoadBeforeFinaleDrop','characters/blackparasite',0,0)
addLuaSprite('blackParasiteLoadBeforeFinaleDrop', false)
setProperty('blackParasiteLoadBeforeFinaleDrop.alpha', 0.01)
end

function onCreatePost()
setProperty('camGame.alpha', 0.01)
setProperty('camGame.zoom', getProperty('camGame.zoom') - 0.1)
setProperty('bgg.alpha', 0.01);
setProperty('dead.alpha', 0.01);
setProperty('bg.alpha', 0.01)
setProperty('splat.alpha', 0.01)
setProperty('lamp.alpha', 0.01);
setProperty('fore.alpha', 0.01);
setProperty('dark.alpha', 0.01);
setProperty('light.alpha', 0.01)
setProperty('defeatthing.y', getProperty('defeatthing.y') + 300)
setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') + 2)
end

function onBeatHit()
if curBeat % 4 == 0 then
if finaleDrop == false then
setProperty('stagefront.alpha', 0.2)
doTweenAlpha('stagething', 'stagefront', 1, 0.4, 'elapsed')
end
end
end

function onSongStart()
removeLuaSprite('blackParasiteLoadBeforeFinaleDrop', false)
doTweenAlpha('camGamefade', 'camGame', 1, 5, 'elapsed')
doTweenZoom('camGamezoomIn', 'camGame', getProperty('camGame.zoom') + 0.1, 5, 'elapsed')
end


function onUpdate()
    setProperty('gf.alpha', 0);

    if curBeat == 32 then
        setProperty('defaultCamZoom',0.8)
    end

    if curBeat < 32 then --start
        triggerEvent('Camera Follow Pos', 750, 800)
    end

    if curBeat >= 32 and curBeat < 48 then --first to black
        triggerEvent('Camera Follow Pos', 450, 1000)
    end
    if curBeat >= 48 and curBeat < 64 then --to bf
        triggerEvent('Camera Follow Pos', 1250, 1000)
    end
    if curBeat >= 64 and curBeat < 68 then --bf zoom in
        triggerEvent('Camera Follow Pos', 1400, 1050)
        setProperty('defaultCamZoom',1.2)
    end
    if curBeat == 67 then
        setProperty('defaultCamZoom',2.4)
    end
    if finaleDrop == false then
    if followchars == true and curBeat >= 68 then
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
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        end
    end
if finaleDrop then
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.44)
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
            setProperty('defaultCamZoom',0.65)
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
end
end
    if curBeat == 492 then
        doTweenZoom('defeated', 'camGame', 2.4, 1.2, 'circIn')
    end
end

function onEvent(n,v1,v2)
if n == 'Finale Drop' then
    removeLuaSprite('stageback', true)
    removeLuaSprite('stagefront', true)
    noteTweenAlpha('DadStrum1', 0, 0, 0.8, 'quadInOut')
    noteTweenAlpha('DadStrum2', 1, 0, 0.8, 'quadInOut')
    noteTweenAlpha('DadStrum3', 2, 0, 0.8, 'quadInOut')
    noteTweenAlpha('DadStrum4', 3, 0, 0.8, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum1', 4, 1, 0.8, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum2', 5, 1, 0.8, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum3', 6, 1, 0.8, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum4', 7, 1, 0.8, 'quadInOut')
    doTweenAlpha('camHUD', 'camHUD', 1, 0.8, 'quadInOut')
removeLuaSprite('defeatthing', true)
setHealth(0.1)
--addLuaScript('stages/finale')
--removeLuaScript('VS Impostor V4/stages/finalem')

setProperty('bgg.alpha', 1);
setProperty('dead.alpha', 1);
setProperty('bg.alpha', 1)
setProperty('splat.alpha', 1)
setProperty('lamp.alpha', 1);
setProperty('fore.alpha', 1);
setProperty('dark.alpha', 1);
setProperty('light.alpha', 1)
finaleDrop = true
xx = 900;
yy = 700;
xx2 = 1000;
yy2 = 850;
ofs = 100;
ofs2 = 50;
followchars = true;
del = 0;
del2 = 0;
end
if n =='Finale End' then
    cameraFlash('other', 'FF1266', 5, true)
    setProperty('scoreTxt.visible', false)
    setProperty('camGame.visible',false)
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)
    setProperty('timeTxt.alpha', 0)
    setProperty('timeBarBG.alpha', 0)
    setProperty('timeBar.alpha', 0)
    noteTweenAlpha('BoyfriendStrum1', 4, 0, 0.1, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum2', 5, 0, 0.1, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum3', 6, 0, 0.1, 'quadInOut')
    noteTweenAlpha('BoyfriendStrum4', 7, 0, 0.1, 'quadInOut')
end
end