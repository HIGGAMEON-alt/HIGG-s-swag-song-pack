local angleshit = 0.3;
local anglevar = 0.3;
local highlight = false;
local xx = 1200;
local yy = 360;

function onCreate()
	makeLuaSprite('woemn', 'woemn', 25, 100);
	setScrollFactor('woemn', 1, 1);
	scaleObject('woemn', 1.7, 1.7);

	makeAnimatedLuaSprite('GFBG2', 'GF_assets2',  1200, 575);
    luaSpriteAddAnimationByPrefix('GFBG2', 'idle', 'GF dead0000', 24, true);
	scaleObject('GFBG2', 1, 1);
	setObjectOrder('GFBG2', 2);
    luaSpritePlayAnimation('GFBG2', 'idle', true);
	
	makeAnimatedLuaSprite('whaud','lighttttt', -400, 50);
            addAnimationByPrefix('whaud', 'idle', 'lighttttt idle' ,60, true)
	addLuaSprite('whaud', true)
	objectPlayAnimation('whaud', 'idle', false)
            setObjectCamera('whaud', 'camGame')
	setProperty('whaud.alpha', 1)
	scaleObject('whaud', 2.2, 2.2)

	makeAnimatedLuaSprite('light','lighttttt', 0, 50);
            addAnimationByPrefix('light', 'idle', 'lighttttt idle' ,60, true)
	addLuaSprite('light', true)
	objectPlayAnimation('light', 'idle', false)
            setObjectCamera('light', 'camGame')
	setProperty('light.alpha', 1)
	scaleObject('light', 2.2, 2.2)


	addLuaSprite('GFBG', false);
	addLuaSprite('GFBG2');
	addLuaSprite('woemn', false);
	addLuaSprite('man', true);

end


function onCreatePost()
	if not isStoryMode then
    setProperty("BotplayTxt.visible",false)

      makeLuaSprite('TimeBarBG','timeBar',defaultOpponentStrumX0,getProperty('timeBar.y'))
      setObjectCamera('TimeBarBG','hud')
      addLuaSprite('TimeBarBG')
      -----------------------
      makeLuaSprite('TimeBar',nil,getProperty('TimeBarBG.x')+4,getProperty('TimeBarBG.y')+4)
      makeGraphic('TimeBar',getProperty('TimeBarBG.width')-8,getProperty('TimeBarBG.height')-8,'00EC00')
      setObjectCamera('TimeBar','hud')
      addLuaSprite('TimeBar')
      -----------------------
      setProperty('TimeBar.visible',false)
      setProperty('timeTxt.visible',false)
      -----------------------
      makeLuaText('TimeTxt',string.upper(songName),0,getProperty('TimeBarBG.x')+12,getProperty('TimeBarBG.y')+2)
      setTextBorder('TimeTxt',1,'000000')
      setTextSize('TimeTxt',12)
      addLuaText('TimeTxt')

      setObjectCamera('TimeTxt','hud')
      setProperty('camHUD.visible',true)
	end
            -----------------------
			if isStoryMode then
				setProperty("BotplayTxt.visible",false)
				setTextColor('scoreTxt','DD0000')
				makeLuaSprite('TimeBarBG','timeBar',defaultOpponentStrumX0,getProperty('timeBar.y'))
				setObjectCamera('TimeBarBG','hud')
				addLuaSprite('TimeBarBG')
				-----------------------
				makeLuaSprite('TimeBar',nil,getProperty('TimeBarBG.x')+4,getProperty('TimeBarBG.y')+4)
				makeGraphic('TimeBar',getProperty('TimeBarBG.width')-8,getProperty('TimeBarBG.height')-8,'00EC00')
				setObjectCamera('TimeBar','hud')
				addLuaSprite('TimeBar')
				-----------------------
				setProperty('TimeBar.visible',false)
				setProperty('timeTxt.visible',false)
				-----------------------
				makeLuaText('TimeTxt',string.upper(songName),0,getProperty('TimeBarBG.x')+12,getProperty('TimeBarBG.y')+2)
				setTextBorder('TimeTxt',1,'000000')
				setTextSize('TimeTxt',12)
				addLuaText('TimeTxt')
		  
				setObjectCamera('TimeTxt','hud')
				setProperty('TimeBar.x',getProperty('TimeBar.x')+30)
				setProperty('TimeTxt.x',getProperty('TimeTxt.x')+30)
				setProperty('TimeBarBG.x',getProperty('TimeBarBG.x')+30)
				setProperty('camHUD.visible',true)
					  -----------------------
  end
end

  function onCountdownTick(swagCounter)
      setObjectCamera('countdownGo','other')
      setObjectCamera('countdownSet','other')
      setObjectCamera('countdownReady','other')
  end

  function onUpdate(elapsed)
      setProperty('timeBar.alpha',0)
      
      if getProperty('timeBar.percent')>0 then
          setProperty('TimeBar.visible',true)
      setGraphicSize('TimeBar',(getProperty('TimeBarBG.width')-8)*(getProperty('timeBar.percent')/100),getProperty('TimeBarBG.height')-8)
      end
    end

function onBeatHit()
	if curBeat > 64 and curBeat < 127 or curBeat > 160 and curBeat < 188 or curBeat > 305 and curBeat < 1349 then
		triggerEvent('Add Camera Zoom', 0.04,0.05)

	    	if curBeat % 2 == 0 then
			angleshit = anglevar;
	    	else
			angleshit = -anglevar;
	    	end
	    	setProperty('camHUD.angle',angleshit*3)
	    	setProperty('camGame.angle',angleshit*3)
	    	doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
	    	doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	    else
	    	setProperty('camHUD.angle',0)
	    	setProperty('camHUD.x',0)
	    	setProperty('camHUD.x',0)
	    end
	end

function onStepHit()
    if curStep == 810 or curStep == 1381 or curStep == 1637 then
	triggerEvent('Camera Follow Pos', 1100, 720)
	end
    if curStep == 848 then
	doTweenAlpha('catahudfade', 'camHUD', 0, 1.5, 'linear');
	end
	if curStep == 1069 then
	doTweenAlpha('catahudfadeback', 'camHUD', 1, 2, 'linear');
	end
	if curStep == 1349 or curStep == 1829 then
	triggerEvent('Camera Follow Pos', 1580, 860)
	end
	
	if curBeat > 256 and curBeat > 504 then
    		if curStep % 4 == 0 then
    			doTweenY('rrr', 'camHUD', -12, stepCrochet*0.002, 'circOut')
	    		doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn')
	    	end
	    	if curStep % 4 == 2 then
    			doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn')
    			doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn')
        	end
    	end
	end