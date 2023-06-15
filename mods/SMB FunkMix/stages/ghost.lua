function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")
	beatsUntilThunder = getRandomInt(5, 24, 5)

	if week == "funkMix" or week == "funkMixDX" then
		makeLuaSprite("bg", "backgrounds/ghost/bg", -160 * 3, -80 * 3)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	else
		if lowQuality then
			makeAnimatedLuaSprite("background", "backgrounds/ghost/ghost", -160 * 3, -80 * 3)
			addAnimationByPrefix("background", "flash", "flash", 6, false)
			setProperty("background.antialiasing", false)
			setProperty("background.animation.curAnim.curFrame", 3)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)
		else
			makeLuaSprite("sky", "backgrounds/ghost/sky", -160 * 3, -80 * 3)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			makeAnimatedLuaSprite("background", "backgrounds/ghost/background", -160 * 3, -80 * 3)
			addAnimationByPrefix("background", "flash", "flash", 6, false)
			setScrollFactor("background", 0.5, 1)
			setProperty("background.antialiasing", false)
			setProperty("background.animation.curAnim.curFrame", 3)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)

			makeLuaSprite("ground", "backgrounds/ghost/ground", -160 * 3, -80 * 3)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)

			makeLuaSprite("foreground", "backgrounds/ghost/foreground", -160 * 3, -80 * 3)
			setProperty("foreground.antialiasing", false)
			scaleObject("foreground", 6, 6)
			addLuaSprite("foreground", false)
		end
	end
end

function onBeatHit()
	if flashingLights then
		if beatsUntilThunder > 0 then
			beatsUntilThunder = beatsUntilThunder - 1
			if beatsUntilThunder <= 0 then
				playAnim("background", "flash")
				updateHitbox("background")
				beatsUntilThunder = getRandomInt(5, 24, 5)
			end
		end
	end
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("background.animation.curAnim.paused", false)
		else
			setProperty("background.animation.curAnim.paused", true)
		end
	end
end