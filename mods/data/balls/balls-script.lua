local sunset = false
local night = false

function onCountdownStarted()
	triggerEvent("Intro","","by LordoftheJimmy")
end

function onBeatHit()
	-- Time Skip Support
	if curBeat >= 56 and sunset == false then
		sunset = true
		doTweenAlpha("sunsetCycle", "sky3", 0, 4, "linear")
	end
	if curBeat >= 96 and sunset and night == false then
		sunset = true
		doTweenAlpha("nightCycle", "sky2", 0, 4, "linear")
	end
end