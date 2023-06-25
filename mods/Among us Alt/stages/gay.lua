function onCreate()
    makeLuaSprite('backstage', 'BG/bg1', 0, 0);
	setLuaSpriteScrollFactor('backstage', 1, 1);
	scaleObject('backstage', 1.25, 1.25);
    addLuaSprite('backstage', false);
    setObjectOrder('backstage',getObjectOrder('backstage2') + 1)

    makeLuaSprite('backstage2', 'BG/bg2', 10, 0);
	setLuaSpriteScrollFactor('backstage2', 1, 1);
	scaleObject('backstage2', 1.25, 1.25);
    addLuaSprite('backstage2', false);
    setObjectOrder('backstage2',getObjectOrder('dad') + 4)
	
	makeLuaSprite('BG_Lights', 'A_lights', 0, 0);
	setLuaSpriteScrollFactor('BG_Lights', 1, 1);
    addLuaSprite('BG_Lights', false);
    setObjectOrder('BG_Lights',getObjectOrder('backstage2') + 1)
	setBlendMode('BG_Lights', 'add')

    makeAnimatedLuaSprite('Line', 'BG/Line',  -250, 0);
    luaSpriteAddAnimationByPrefix('Line', 'idle', 'lines 인스턴스 10', 24, true);
scaleObject('Line', 1.5, 1.5);
setObjectOrder('Line', 2);
    luaSpritePlayAnimation('Line', 'idle', true);
    addLuaSprite('Line', false);

	setObjectOrder('Line',getObjectOrder('dad') + 5)
    setObjectOrder('Line',getObjectOrder('bf') + 8)
    
    makeLuaSprite('flashM', 'flashM', 0, 0);
    setLuaSpriteScrollFactor('flashM', 0, 0);
    doTweenColor('flashcolour', 'flashM', '990000', 0.01, 'linear');
        setProperty('flashM.alpha', 0.0);
        doTweenAlpha('flashalpha', 'flashM', 0, 0.001, 'linear');
    setObjectCamera('flashM', 'camHUD');
    addLuaSprite('flashM', true);
    precacheImage('flashM')
end
-- dsa

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

function onStepHit()
   if curStep == 1080 then
   setCharacterX('boyfriend', 1000);
   setProperty('backstage.alpha', 0);
   setProperty('backstage2.alpha', 0);
   setProperty('Line.alpha', 0);
   end
   if curStep == 1488 then
   setCharacterX('boyfriend', 1150);
   setProperty('backstage.alpha', 1);
   setProperty('backstage2.alpha', 1);
   setProperty('Line.alpha', 1);
   end
   if curStep == 1752 then
   startVideo('cut3')
   setProperty('inCutscene', false);
   setProperty('backstage.alpha', 0);
   setProperty('backstage2.alpha', 0);
   setProperty('Line.alpha', 0);
   setProperty('boyfriend.alpha', 0);
   setProperty('dad.alpha', 0);
   setProperty('camHUD.alpha', 0);
   end
end