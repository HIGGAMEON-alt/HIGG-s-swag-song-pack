local lifeTime = 0
local decay = 0
local originalScale = 1
local originalY = 0
local originalHeight = 400
local newHeight = 0
local lightId = 0
local curLightEvent = -1
local phillyLightsColors = {0x009C19CE}
local phillyLightsColorsString = {"9C19CE"}
local color = 0x009C19CE

function onCreate()
	if week ~= "funkMixDX" then
		makeLuaSprite("phillyGlowGradient", "gradient", -400, 0)
		originalY = getProperty("phillyGlowGradient.y")
		setScrollFactor("phillyGlowGradient", 0, 0.75)
		setGraphicSize("phillyGlowGradient.visible", 2000, originalHeight)
		updateHitbox("phillyGlowGradient")
		setProperty("phillyGlowGradient.visible", false)
		setObjectOrder("phillyGlowGradient", getObjectOrder("level") + 1)

		makeLuaSprite("bombWah", "backgrounds/wrecking-crew/bomb-wah", getProperty("bomb2.x"), getProperty("bomb2.y"))
		setScrollFactor("bombWah", 1, 1)
		setProperty("bombWah.antialiasing", false)
		scaleObject("bombWah", 6, 6)
		updateHitbox("bombWah")
		setObjectOrder("bombWah", getObjectOrder("bomb2") + 1)
		setProperty("bombWah.visible", false)
		addLuaSprite("bombWah", false)
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

function onBeatHit()
	-- Auto Bop
	if week ~= "funkMixDX" or not flashingLights then
		if curBeat % 1 == 0 then
			bop()
		end

		if curBeat == 176 then
			waluigiTime(1)
		elseif curBeat == 272 then
			waluigiTime(0)
		end
	end
end

function waluigiTime(switch)
	lightId = switch
	if lightId == 0 then
		if getProperty("phillyGlowGradient.visible") then
			cameraFlash("game", "FFFFFF", 0.15, true)
			setProperty("phillyGlowGradient.color", 0x00FFFFFF)
			setProperty("phillyGlowGradient.visible", false)
			setProperty("bombWah.visible", false)
			if lowQuality then
				loadGraphic("bg", "backgrounds/wrecking-crew/wrecking-crew")
			else
				loadGraphic("sky", "backgrounds/wrecking-crew/sky")
				loadGraphic("level", "backgrounds/wrecking-crew/level")
				loadGraphic("background", "backgrounds/wrecking-crew/background")
				loadGraphic("ground", "backgrounds/wrecking-crew/ground")
			end
			curLightEvent = -1
		end
	elseif lightId == 1 then -- turn On
		curLightEvent = getRandomInt(1, #phillyLightsColors, curLightEvent)
		color = phillyLightsColors[curLightEvent]

		if not getProperty("phillyGlowGradient.visible") then
			cameraFlash("game", "FFFFFF", 0.15, true)
			setProperty("phillyGlowGradient.color", color)
			setProperty("phillyGlowGradient.visible", true)
			setProperty("bombWah.visible", true)
			if lowQuality then
				loadGraphic("bg", "backgrounds/wrecking-crew/wrecking-crew-wah")
			else
				loadGraphic("sky", "backgrounds/wrecking-crew/sky-wah")
				loadGraphic("level", "backgrounds/wrecking-crew/level-wah")
				loadGraphic("background", "backgrounds/wrecking-crew/background-wah")
				loadGraphic("ground", "backgrounds/wrecking-crew/ground-wah")
			end
		end
	end
end