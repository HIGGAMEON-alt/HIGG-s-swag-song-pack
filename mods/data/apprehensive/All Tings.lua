-- plz kill me -haryu5412-
-- lua is sucks 
-- why not working bitch

function onCreate()
    setProperty('skipCountdown', true)
    addLuaScript('data/fuck.lua')
    setProperty('TimeBar.x',getProperty('TimeBar.x')+30)
    setProperty('TimeTxt.x',getProperty('TimeTxt.x')+30)
    setProperty('TimeBarBG.x',getProperty('TimeBarBG.x')+30)
end

function onCountdownTick(swagCounter)
    setObjectCamera('countdownGo','other')
    setObjectCamera('countdownSet','other')
    setObjectCamera('countdownReady','other')
end

function onUpdate(onStepHit)
    if curStep == 0 then
    triggerEvent('Camera Follow Pos', '760', '450');
    addLuaScript('data/smoothcam.lua')

    makeLuaSprite('bb', 'HE IS BLACK', -200, 0);
    setLuaSpriteScrollFactor('bb', 0.9, 0.9);
        doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');
    setObjectCamera('bb', 'camGame');
    addLuaSprite('bb', true);
    precacheImage('bb')

    elseif curStep == 1 then
        --setObjectOrder('Line',getObjectOrder('dad') + 5)
        --setObjectOrder('backstage',getObjectOrder('backstage2') + 1)
        --setObjectOrder('backstage2',getObjectOrder('dad') + 4)


    elseif curStep == 128 then
        triggerEvent('Camera Follow Pos', '', '');
        
    elseif curStep == 138 then
        doTweenAlpha('bbal', 'bb', 1, 0.3, 'linear');

    elseif curStep == 144 then
        doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

    elseif curStep == 1168 then
        doTweenAlpha('flashalpha', 'flashM', 1, 0.001, 'linear'); 
    
        elseif curStep == 1169 then
            doTweenAlpha('flashalpha', 'flashM', 0, 0.9, 'linear'); 

        elseif curStep == 1273 then
            doTweenAlpha('bbal', 'bb', 1, 0.45, 'linear');
    
        elseif curStep == 1278 then
            doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

        elseif curStep == 1298 then
            doTweenAlpha('bbal', 'bb', 1, 0.45, 'linear');
    
        elseif curStep == 1303 then
            doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

        elseif curStep == 1369 then
            doTweenAlpha('bbal', 'bb', 1, 0.45, 'linear');
    
        elseif curStep == 1374 then
            doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

        elseif curStep == 1393 then
            doTweenAlpha('bbal', 'bb', 1, 0.45, 'linear');
    
        elseif curStep == 1398 then
            doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

    elseif curStep == 1080 then
            doTweenAlpha('boyfriend', 'boyfriend', 0.6, 0.001, linear);
    
        elseif curStep == 1488 then
            doTweenAlpha('boyfriend2', 'boyfriend', 1, 0.001, linear);

        elseif curStep == 1473 then
            doTweenAlpha('bbal', 'bb', 1, 0.001, 'linear');
            doTweenAlpha('AlphaTween2', 'healthBar', 0, 0.001)
            doTweenAlpha('AlphaTween3', 'scoreTxt', 0, 0.001)
            doTweenAlpha('AlphaTween4', 'iconP1', 0, 0.001)
            doTweenAlpha('AlphaTween5', 'iconP2', 0, 0.001)
            doTweenAlpha('AlphaTween6', 'TimeBar', 0, 0.001)
            doTweenAlpha('AlphaTween7', 'TimeBarBG', 0, 0.001)
            doTweenAlpha('AlphaTween8', 'TimeTxt', 0, 0.001)
            doTweenAlpha('AlphaTween9', 'BotplayTxt', 0, 0.001)	
        elseif curStep == 1493 then
-----------------------------------------------------------------------

        elseif curStep == 1473 then
-----------------------------------------------------------------------
elseif curStep == 1494 then
        elseif curStep == 1500 then
            doTweenAlpha('bbal', 'bb', 0, 0.001, 'linear');

end
end

-- Cam  Zoom
