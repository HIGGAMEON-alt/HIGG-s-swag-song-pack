function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	makeLuaSprite("sky", "backgrounds/minus/sky", -160 * 3, -80 * 3)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

	if week == "funkMixDX" or lowQuality then
		makeAnimatedLuaSprite("minusBG", "backgrounds/minus/bg", -160 * 3, -80 * 3)
		addAnimationByIndices("minusBG", "glitch", "anim0", "1, 2, 3, 0", 9)
		setProperty("minusBG.animation.curAnim.curFrame", 3)
		setProperty("minusBG.antialiasing", false)
		scaleObject("minusBG", 6, 6)
		addLuaSprite("minusBG", false)
	else
		makeAnimatedLuaSprite("background", "backgrounds/minus/background", -160 * 3, -80 * 3)
		addAnimationByIndices("background", "glitch", "anim0", "1, 2, 3, 0", 9)
		setProperty("background.animation.curAnim.curFrame", 3)
		if week ~= "funkMixDX" then
			setScrollFactor("background", 0.5, 1)
		end
		setProperty("background.antialiasing", false)
		scaleObject("background", 6, 6)
		addLuaSprite("background", false)

		makeAnimatedLuaSprite("ground", "backgrounds/minus/ground", -160 * 3, -80 * 3)
		addAnimationByIndices("ground", "glitch", "anim0", "1, 2, 3, 0", 9)
		setProperty("ground.animation.curAnim.curFrame", 3)
		setProperty("ground.antialiasing", false)
		scaleObject("ground", 6, 6)
		addLuaSprite("ground", false)
	end
end

function onBeatHit()
	if curBeat % 8 == 0 and flashingLights then
		playAnim("minusBG", "glitch")
		playAnim("background", "glitch")
		playAnim("ground", "glitch")
		updateHitbox("minusBG")
		updateHitbox("background")
		updateHitbox("ground")
	end
end

function onUpdate()
	if isRunning("scripts/extra/menus/Pause") then
		if getTextString("isPaused") ~= "true" then
			setProperty("minusBG.animation.curAnim.paused", false)
			setProperty("background.animation.curAnim.paused", false)
			setProperty("ground.animation.curAnim.paused", false)
		else
			setProperty("minusBG.animation.curAnim.paused", true)
			setProperty("background.animation.curAnim.paused", true)
			setProperty("ground.animation.curAnim.paused", true)
		end
	end
end