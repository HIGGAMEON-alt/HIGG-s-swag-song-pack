function onCreatePost()
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