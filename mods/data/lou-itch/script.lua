local allowCountdown = false
function onStartCountdown()
makeLuaSprite('fog', 'fog', 0, 0)
setScrollFactor('fog', 0.7, 0.7)
defaultCamZoom = getProperty('defaultCamZoom') - 1
setObjectCamera('fog','hud')
scaleObject('fog', 1.6, 1.6)
setProperty('fog.alpha', 0)
addLuaSprite('fog')
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('1');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onStepHit()
    if curStep == 1151 then
	    doTweenAlpha('byebg', 'fog', 1, 1, 'linear');
		runTimer('fog', 1, 1)
        doTweenX('fog', 'fog', -700, 42, linear)
    end
	if curStep == 1567 then
	    doTweenAlpha('byebg', 'fog', 0, 1, 'linear');
		
    end
end