function onCreate()

	makeLuaSprite('woemn', 'woemn', 25, 100);
	setScrollFactor('woemn', 1, 1);
	scaleObject('woemn', 1.7, 1.7);

	makeAnimatedLuaSprite('light','lighttttt', -400, 50);
            addAnimationByPrefix('light', 'idle', 'lighttttt idle' ,60, true)
	addLuaSprite('light', true)
	objectPlayAnimation('light', 'idle', false)
            setObjectCamera('light', 'camGame')
	setProperty('light.alpha', 0)
	scaleObject('light', 2.2, 2.2)


	makeAnimatedLuaSprite('lighttyy','lightttt', 0, 50);
            addAnimationByPrefix('lighttyy', 'idle', 'lighttttt idle' ,60, true)
	addLuaSprite('lighttyy', true)
	objectPlayAnimation('lighttyy', 'idle', false)
            setObjectCamera('lighttyy', 'camGame')
	setProperty('lighttyy.alpha', 1)
	scaleObject('lighttyy', 2.2, 2.2)

	makeAnimatedLuaSprite('GFBG', 'GF_assets',  1200, 400);
    luaSpriteAddAnimationByPrefix('GFBG', 'idle', 'GF Dancing Beat0', 24, true);
	scaleObject('GFBG', 1, 1);
	setObjectOrder('GFBG', 2);
    luaSpritePlayAnimation('GFBG', 'idle', true);

	makeAnimatedLuaSprite('GFBG2', 'GF_assets2',  1200, 575);
    luaSpriteAddAnimationByPrefix('GFBG2', 'idle', 'GF dead0000', 24, true);
	scaleObject('GFBG2', 1, 1);
	setObjectOrder('GFBG2', 2);
    luaSpritePlayAnimation('GFBG2', 'idle', true);
	doTweenAlpha('flTw','GFBG2' ,0 ,0.001,'linear')

	addLuaSprite('woemn', false);
	addLuaSprite('GFBG', false);
	addLuaSprite('GFBG2', false);
	addLuaSprite('man', true);

end

function onUpdate()
	if curStep == 1472 then
	doTweenAlpha('alphaTween', 'light', 1, 1)
	end
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



