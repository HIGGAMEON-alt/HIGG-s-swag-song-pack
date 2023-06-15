local lifeTime = 0
local decay = 0
local originalScale = 1
local originalY = 0
local originalHeight = 720
local newHeight = 0
local lightId = 0
local curLightEvent = -1
local phillyLightsColors = {0x00e99e07}
local phillyLightsColorsString = {"e99e07"}
local color = 0x00e99e07

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	if week ~= "funkMix" and week ~= "funkMixDX" then
		makeLuaSprite("phillyGlowGradient", "gradient", 0, 0)
		originalY = getProperty("phillyGlowGradient.y")
		setScrollFactor("phillyGlowGradient", 0, 0.75)
		setGraphicSize("phillyGlowGradient.visible", 2000, originalHeight)
		updateHitbox("phillyGlowGradient")
		setProperty("phillyGlowGradient.visible", false)
		setObjectOrder("phillyGlowGradient", getObjectOrder("stormClouds3") + 1)
		addLuaSprite("phillyGlowGradient")
	end
end

function onUpdate(elapsed)
	-- Gradient
	if getTextString("isPaused") ~= "true" then
		newHeight = math.floor(getProperty("phillyGlowGradient.height") - 1000 * elapsed)
		if newHeight > 0 then
			setProperty("phillyGlowGradient.alpha", 1)
			setGraphicSize("phillyGlowGradient", 2000, newHeight)
			updateHitbox("phillyGlowGradient")
			setProperty("phillyGlowGradient.y", originalY + (originalHeight - getProperty("phillyGlowGradient.height")))
		else
			setProperty("phillyGlowGradient.alpha", 0)
			setProperty("phillyGlowGradient.y", -5000)
		end
	end
end

function bop()
	setGraphicSize("phillyGlowGradient", 2000, originalHeight)
	updateHitbox("phillyGlowGradient")
	setProperty("phillyGlowGradient.y", originalY)
	setProperty("phillyGlowGradient.alpha", 1)
end

function onStepHit()
	-- Auto Bop
	if (week ~= "funkMix" and week ~= "funkMixDX") or not flashingLights then
		if curStep == 832 then
			showtime(1)
		elseif curStep == 1088 then
			showtime(0)
		end
	end

	if curStep == 832 then
		bop()
	elseif curStep == 840 or curStep == 856 or curStep == 872 or curStep == 888 or curStep == 904 or curStep == 920 or curStep == 936 or curStep == 952 or curStep == 954 or curStep == 956 or curStep == 958 or curStep == 968 or curStep == 984 or curStep == 1000 or curStep == 1016 or curStep == 1032 or curStep == 1048 or curStep == 1064 or curStep == 1080 then
		if not funkMixCam() then
			setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.5/2)
			setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.1/2)
		else
			bop()
		end
	elseif curStep == 848 or curStep == 852 or curStep == 864 or curStep == 880 or curStep == 884 or curStep == 896 or curStep == 912 or curStep == 916 or curStep == 928 or curStep == 944 or curStep == 948 or curStep == 976 or curStep == 980 or curStep == 992 or curStep == 1008 or curStep == 1012 or curStep == 1024 or curStep == 1040 or curStep == 1044 or curStep == 1056 or curStep == 1072 or curStep == 1076 then
		bop()
	elseif curStep == 960 then
		bop()
		if not funkMixCam() then
			setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.5)
			setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.1)
		end
	elseif curStep == 1088 then
		bop()
	end
end

function showtime(switch)
	lightId = switch
	if lightId == 0 then
		if getProperty("phillyGlowGradient.visible") then
			cameraFlash("game", "FFFFFF", 0.15, true)
			setProperty("phillyGlowGradient.color", 0x00FFFFFF)
			setProperty("phillyGlowGradient.visible", false)
			if lowQuality then
				loadGraphic("stormClouds", "backgrounds/airship/bg")
				loadGraphic("stormClouds2", "backgrounds/airship/bg")
				loadGraphic("stormClouds3", "backgrounds/airship/bg")
			else
				loadGraphic("sky", "backgrounds/airship/sky")
				loadGraphic("stormClouds", "backgrounds/airship/stormClouds")
				loadGraphic("stormClouds2", "backgrounds/airship/stormClouds")
				loadGraphic("stormClouds3", "backgrounds/airship/stormClouds")
			end
			updateHitbox("stormClouds")
			updateHitbox("stormClouds2")
			updateHitbox("stormClouds3")
			curLightEvent = -1
		end
	elseif lightId == 1 then -- turn On
		curLightEvent = getRandomInt(1, #phillyLightsColors, curLightEvent)
		color = phillyLightsColors[curLightEvent]

		if not getProperty("phillyGlowGradient.visible") then
			cameraFlash("game", "FFFFFF", 0.15, true)
			setProperty("phillyGlowGradient.color", color)
			setProperty("phillyGlowGradient.visible", true)
			if lowQuality then
				loadGraphic("stormClouds", "backgrounds/airship/bgBows")
				loadGraphic("stormClouds2", "backgrounds/airship/bgBows")
				loadGraphic("stormClouds3", "backgrounds/airship/bgBows")
			else
				loadGraphic("sky", "backgrounds/airship/skyBows")
				loadGraphic("stormClouds", "backgrounds/airship/stormCloudsBows")
				loadGraphic("stormClouds2", "backgrounds/airship/stormCloudsBows")
				loadGraphic("stormClouds3", "backgrounds/airship/stormCloudsBows")
			end
			updateHitbox("stormClouds")
			updateHitbox("stormClouds2")
			updateHitbox("stormClouds3")
		end
	end
end