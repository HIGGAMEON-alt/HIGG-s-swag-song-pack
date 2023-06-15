local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCountdownStarted()
	triggerEvent("Intro","","by coquers_")
end

function onBeatHit()
	if curBeat == 128 then
		setProperty("iconLuigi.visible", true)
		setProperty("iconP2.visible", false)
		reloadHealthBarColors(0x00388700, nil)
	end
	
	if not funkMixCam() then
		if curBeat == 228 then
			setProperty("defaultCamZoom", 2.5)
		end
	end
end

function reloadHealthBarColors(dadColor, bfColor)
	if dadColor ~= nil then
		setProperty("healthBarDAD.color", dadColor)
		setProperty("healthArrowDAD.color", dadColor)
	end
	if bfColor ~= nil then
		setProperty("healthBarBF.color", bfColor)
		setProperty("healthArrowBF.color", bfColor)
	end
end