function onCreate()
	setObjectOrder('dad',getObjectOrder('boyfriend') + 5)
	setProperty('skipCountdown', true)

	
makeLuaSprite('yellowbg', 'yellowbg', -500, -200)
setScrollFactor('yellowbg', 1, 1)
scaleObject('yellowbg', 1.0, 1.0);

makeLuaSprite('bfy', 'bfy', -500, -200)
setScrollFactor('bfy', 1, 1)
scaleObject('bfy', 0.5, 0.5);
setObjectCamera('bfy', 'camGame')

makeAnimatedLuaSprite('bughead','bughead', 670, 350);
addAnimationByPrefix('bughead', 'idle', 'bughead idle' ,12, true)
addLuaSprite('bughead', true)
objectPlayAnimation('bughead', 'idle', false)
setObjectCamera('bughead', 'camGame')
setProperty('bughead.alpha', 1)
scaleObject('bughead', 0.4, 0.4)

makeLuaSprite('lighting', 'lighting', -510, -200)
setScrollFactor('lighting', 1, 1)
scaleObject('lighting', 1.0, 1.0);

makeAnimatedLuaSprite('space','space', 150, 150);
addAnimationByPrefix('space', 'idle', 'space idle' ,12, true)
objectPlayAnimation('space', 'idle', true)
addLuaSprite('space', true)
setObjectCamera('space', 'other')
setProperty('space.alpha', 0)
scaleObject('space', 1, 1)

addLuaSprite('yellowbg', false)
addLuaSprite('bfy', false)
addLuaSprite('lighting', true)

makeLuaSprite('startdark','HE IS BLACK', 0, 0);
addLuaSprite('startdark')
setObjectCamera('startdark', 'Other')
end

function onStepHit()
    if curStep == 1 then
	--startVideo('jumpscare')
    --setProperty('inCutscene', true);
	setProperty('startdark.alpha', 0)
    end
	if curStep == 128 then
	--setProperty('inCutscene', false);
	end
	if curStep == 244 then
	setProperty('space.alpha', 1)
	end
	if curStep == 260 then
	setProperty('space.alpha', 0)
	end
	
end
	
function onCreatePost()

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
