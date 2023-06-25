local inSpace = false

function onCountdownStarted()
	triggerEvent("Intro","","by Saruky\nRemix by KirbyKid")
end

function onBeatHit()
	if curBeat >= 364 and inSpace == false then
		inSpace = true
		doTweenY("bgRemove", "bg", -81 * 15, 1, "quadIn")
		doTweenY("groundRemove", "ground", 81 * 2, 1, "quadIn")
		doTweenY("platformAdd", "platform", 121 * 3, 1, "quintOut")
    end
end