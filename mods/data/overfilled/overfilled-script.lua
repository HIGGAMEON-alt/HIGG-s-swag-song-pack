function onCountdownStarted()
	triggerEvent("Intro","","by TECHPACK")
end

function onBeatHit()
	if curBeat == 96 then
		setProperty("transition.x", -160 * 3 + getProperty("transition.width"))
		setProperty("transition.visible", true)
	elseif curBeat == 100 then
		removeLuaSprite("groundApt", true)
		removeLuaSprite("backgroundApt", true)
		removeLuaSprite("groundApt2", true)
		removeLuaSprite("backgroundApt2", true)
		removeLuaSprite("groundApt3", true)
		removeLuaSprite("backgroundApt3", true)
	end
end