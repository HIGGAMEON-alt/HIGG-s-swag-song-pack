function onCreate()
	--agonmus
	makeLuaSprite('floor', 'BG/horse/floor', -300, -1000);
	setScrollFactor('floor', 1, 1);
	makeLuaSprite('weed', 'BG/horse/weed', -650, -1500);
	setScrollFactor('weed', 1, 1);
	scaleObject('weed', 1.25, 1.25);
	makeLuaSprite('bg', 'BG/horse/back', -300, -1050);
	setScrollFactor('bg', 0.75, 0.75);
	makeLuaSprite('MT', 'BG/horse/Mountain', -300, -750);
	setScrollFactor('MT', 0.5, 0.5);
	makeLuaSprite('sky', 'BG/horse/sky', -300, -1050);
	setScrollFactor('sky', 0.75, 0.75);
	
	makeAnimatedLuaSprite('black','BG/horse/bghorse', 500, 435)
	addAnimationByPrefix('black','loop','black',24,true)
    objectPlayAnimation('black','loop',true);
	
	makeAnimatedLuaSprite('white','BG/horse/bghorse', 750, 490)
	addAnimationByPrefix('white','loop','white',24,false)
    objectPlayAnimation('white','loop',false);
	
	makeAnimatedLuaSprite('green','BG/horse/bghorse', 1300, 525)
	addAnimationByPrefix('green','loop','green',24,false)
    objectPlayAnimation('green','loop',false);
	
	makeAnimatedLuaSprite('red','BG/horse/bghorse', 1450, 535)
	addAnimationByPrefix('red','loop','red',24,false)
    objectPlayAnimation('red','loop',false);
	
	makeAnimatedLuaSprite('yellow','BG/horse/bghorse', 1600, 625)
	addAnimationByPrefix('yellow','loop','yellow',24,false)
    objectPlayAnimation('yellow','loop',false);
	scaleObject('yellow', 1.25, 1.25);
	setScrollFactor('yellow', 0.75, 1);
	
	makeAnimatedLuaSprite('grey','BG/horse/bghorse', -300, 625)
	addAnimationByPrefix('grey','loop','grey',24,false)
    objectPlayAnimation('grey','loop',false);
	scaleObject('grey', 1.25, 1.25);
	setScrollFactor('grey', 0.75, 1);
	
-- sprites that only load if Low Quality is turned off
	if not lowQuality then
	
	end 

	addLuaSprite('sky', false)
	addLuaSprite('MT', false)
	addLuaSprite('bg', false)
	addLuaSprite('floor', false)
	
	addLuaSprite('white', false)
	addLuaSprite('black', false)
	addLuaSprite('green', false)
	addLuaSprite('red', false)
	addLuaSprite('weed', false)
	
	addLuaSprite('yellow', true)
	addLuaSprite('grey', true)

	
end

function onBeatHit()
	if curBeat % 2 == 0 then
	objectPlayAnimation('white','loop', false);
	objectPlayAnimation('green','loop', false);
	objectPlayAnimation('red','loop', false);
	objectPlayAnimation('yellow','loop', false);
	objectPlayAnimation('grey','loop', false);
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
				setProperty('TimeBar.x',getProperty('TimeBar.x')+60)
				setProperty('TimeTxt.x',getProperty('TimeTxt.x')+60)
				setProperty('TimeBarBG.x',getProperty('TimeBarBG.x')+60)
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
