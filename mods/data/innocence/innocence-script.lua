local xx = 160 * 3
local yy = 81 * 3

function onCreate()
	addLuaScript("scripts/extra/VCR Effect (For OS Engine)")
	if lowQuality then
		triggerEvent("Camera Follow Pos",xx,yy)
	end
end

function onCountdownStarted()
	triggerEvent("Intro","","by KrystalPhantasm\nvocals by Jatotz")
end

function onStepHit()
	if not lowQuality then
		if curStep == 704 then
			triggerEvent("Camera Follow Pos", xx, yy + (5 * 6))
			setProperty("defaultCamZoom", 1 + (1/3) + 0.001)
			--setProperty("sky.visible", false)
			-- setProperty("groundFake.visible", false)
			doTweenAlpha("skyBlack", "sky", 0, 6, "linear")
			doTweenAlpha("groundFadeOut", "groundFake", 0, 6, "linear")
		end
	end
end