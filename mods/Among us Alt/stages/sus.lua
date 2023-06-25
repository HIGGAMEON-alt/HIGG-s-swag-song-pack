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



function onCreate()
	--agonmus

	makeLuaSprite('blue', 'blue', 100, 225);
	setScrollFactor('blue', 1, 1);
	scaleObject('blue', 0.6, 0.5);

	makeAnimatedLuaSprite('purple','purple', 2000, 600);
            addAnimationByPrefix('purple', 'idle', 'purple idle' ,16, true)
            addAnimationByPrefix('purple', 'godehd', 'purple godehd' ,16, true)
            addAnimationByPrefix('purple', 'ektlehdwkr', 'purple ektlehdwkr' ,12, true)
	addLuaSprite('purple', true)
	objectPlayAnimation('purple', 'idle', false)
            setObjectCamera('purple', 'camGame')
	setProperty('purple.alpha', 1)
	scaleObject('purple', 1.4, 1.4)

	makeAnimatedLuaSprite('white','White', -1500, 500);
            addAnimationByPrefix('white', 'idle', 'White idle' ,60, true)
	addLuaSprite('white', true)
	objectPlayAnimation('white', 'idle', false)
            setObjectCamera('white', 'camGame')
	setProperty('white.alpha', 1)
	scaleObject('white', 1.65, 1.65)

	makeAnimatedLuaSprite('white3','white3', 2000, 600);
            addAnimationByPrefix('white3', 'idle', 'white3 idle' ,16, true)
	addLuaSprite('white3', true)
	objectPlayAnimation('white3', 'idle', false)
            setObjectCamera('white3', 'camGame')
	setProperty('white3.alpha', 1)
	scaleObject('white3', 1.4, 1.4)

	makeAnimatedLuaSprite('gray','gray', -1500, 550);
            addAnimationByPrefix('gray', 'idle', 'gray idle' ,16, true)
            addAnimationByPrefix('gray', 'enlehfdkqhr', 'gray enlehfdkqhr' ,12, true)
            addAnimationByPrefix('gray', 'enlehfdkqhrhflema', 'gray enlehfdkqhrhflema' ,16, true)
            addAnimationByPrefix('gray', 'ektldkvqhr', 'gray ektldkvqhr' ,16, true)
            addAnimationByPrefix('gray', 'tlcpqkfrus', 'gray tlcpqkfrus' ,16, true)
            addAnimationByPrefix('gray', 'ehakdcu', 'gray ehakdcu' ,20, true)
            addAnimationByPrefix('gray', 'ehakdeorl', 'gray ehakdeorl' ,26, true)
	addLuaSprite('gray', true)
	objectPlayAnimation('gray', 'idle', false)
            setObjectCamera('gray', 'camGame')
	setProperty('gray.alpha', 1)
	scaleObject('gray', 1.4, 1.4)

	makeAnimatedLuaSprite('yellow','pale yellow', 2000, 600);
            addAnimationByPrefix('yellow', 'idle', 'pale yellow idle' ,16, true)
            addAnimationByPrefix('yellow', 'dkfofhrjer', 'pale yellow dkfofhrjer' ,16, true)
	addLuaSprite('yellow', true)
	objectPlayAnimation('yellow', 'idle', false)
            setObjectCamera('yellow', 'camGame')
	setProperty('yellow.alpha', 1)
	scaleObject('yellow', 1.4, 1.4)

	makeAnimatedLuaSprite('white3','white3', 2000, 600);
            addAnimationByPrefix('white3', 'idle', 'white3 idle' ,16, true)
	addLuaSprite('white3', true)
	objectPlayAnimation('white3', 'idle', false)
            setObjectCamera('white3', 'camGame')
	setProperty('white3.alpha', 1)
	scaleObject('white3', 1.4, 1.4)

	makeAnimatedLuaSprite('coral','coral', 2000, 600);
            addAnimationByPrefix('coral', 'idle', 'coral idle' ,16, true)
            addAnimationByPrefix('coral', 'RkaWkr', 'coral RkaWkr' ,16, true)
	addLuaSprite('coral', true)
	objectPlayAnimation('coral', 'idle', false)
            setObjectCamera('coral', 'camGame')
	setProperty('coral.alpha', 1)
	scaleObject('coral', 1.4, 1.4)

	makeAnimatedLuaSprite('sans','sans', -2000, 0);
            addAnimationByPrefix('sans', 'idle', 'White idle' ,60, true)
	addLuaSprite('sans', true)
	objectPlayAnimation('sans', 'idle', false)
            setObjectCamera('sans', 'camOther')
	setProperty('sans.alpha', 1)
	scaleObject('sans', 2, 2)

	makeAnimatedLuaSprite('light','light', 0, 225);
            addAnimationByPrefix('light', 'idle', 'light idle' ,60, true)
            addAnimationByPrefix('light', 'alt', 'light alt' ,3, true)
	addLuaSprite('light', true)
	objectPlayAnimation('light', 'idle', false)
            setObjectCamera('light', 'camGame')
	setProperty('light.alpha', 1)
	scaleObject('light', 1.5, 1.5)
	
-- sprites that only load if Low Quality is turned off
	if not lowQuality then
	
	end 

	addLuaSprite('blue', false)


end


function onUpdate()
	if curStep == 10 then
	objectPlayAnimation('purple', 'idle', true)
	end
	if curStep == 445 then
	doTweenX('alphaTweer', 'purple', 1100, 6)
	end
	if curStep == 522 then
	objectPlayAnimation('purple', 'godehd', true)
	end
	if curStep == 531 then
	objectPlayAnimation('purple', 'ektlehdwkr', true)
	end
	if curStep == 1040 then
	objectPlayAnimation('purple', 'idle', true)
	end
	if curStep == 1040 then
	doTweenX('alphaTweer', 'purple', -1500, 5.5)
	end
	if curStep == 128 then
	doTweenX('alphaTweer', 'white3', -1500, 6)
	end
	if curStep == 406 then
	doTweenX('alphaTweer', 'white', 2500, 1.5)
	end
	if curStep == 256 then
	doTweenX('alphaTweer', 'yellow', 800, 6)
	end
	if curStep == 330 then
	doTweenY('alphaTweer', 'yellow', 2000, 3)
	end
	if curStep == 330 then
	objectPlayAnimation('yellow', 'dkfofhrjer', true)
	end
	if curStep == 620 then
	doTweenX('alphaTweer', 'gray', -200, 6)
	end
	if curStep == 696 then
	objectPlayAnimation('gray', 'enlehfdkqhr', true)
	end
	if curStep == 702 then
	objectPlayAnimation('gray', 'enlehfdkqhrhflema', true)
	end
	if curStep == 894 then
	objectPlayAnimation('gray', 'ektldkvqhr', true)
	end
	if curStep == 898 then
	objectPlayAnimation('gray', 'idle', true)
	end
	if curStep == 898 then
	doTweenX('alphaTweer', 'gray', 100, 1.5)
	end
	if curStep == 920 then
	objectPlayAnimation('gray', 'tlcpqkfrus', true)
	end
	if curStep == 930 then
	objectPlayAnimation('gray', 'ehakdcu', true)
	end
	if curStep == 933 then
	objectPlayAnimation('gray', 'ehakdeorl', true)
	end
	if curStep == 933 then
	doTweenX('alphaTweer', 'gray', 2500, 1)
	end
	if curStep == 760 then
	doTweenX('alphaTweer', 'coral', -2000, 7.5)
	end
	if curStep == 10000 then
	doTweenX('alphaTweer', 'sans', 20000, 8)
	end
	if curStep == 784 then
	objectPlayAnimation('light', 'idle', true)
	end





end
function onBeatHit()
--objectPlayAnimation('purple', 'idle', false)
end