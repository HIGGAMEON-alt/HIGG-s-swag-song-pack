function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	if week ~= "funkMixDX" then
		if lowQuality then
			makeLuaSprite("bg", "backgrounds/wrecking-crew/wrecking-crew", -160 * 3, -81 * 3 + 3)
			setScrollFactor("bg", 1, 1)
			setProperty("bg.antialiasing", false)
			scaleObject("bg", 6, 6)
			addLuaSprite("bg", false)
		else
			makeLuaSprite("sky", "backgrounds/wrecking-crew/sky", -160 * 3, -81 * 3 + 3)
			setScrollFactor("sky", 1, 1)
			setProperty("sky.antialiasing", false)
			scaleObject("sky", 6, 6)
			addLuaSprite("sky", false)

			makeLuaSprite("level", "backgrounds/wrecking-crew/level", -160 * 2.75, -81 * 3 + 3)
			setScrollFactor("level", 0.75, 1)
			setProperty("level.antialiasing", false)
			setProperty("level.alpha", 0.5)
			scaleObject("level", 6, 6)
			addLuaSprite("level", false)

			makeLuaSprite("background", "backgrounds/wrecking-crew/background", -160 * 3, -81 * 3 + 3)
			setScrollFactor("background", 1, 1)
			setProperty("background.antialiasing", false)
			scaleObject("background", 6, 6)
			addLuaSprite("background", false)

			makeLuaSprite("ground", "backgrounds/wrecking-crew/ground", -160 * 3, -81 * 3 + 3)
			setScrollFactor("ground", 1, 1)
			setProperty("ground.antialiasing", false)
			scaleObject("ground", 6, 6)
			addLuaSprite("ground", false)
		end
	else
		makeLuaSprite("bg", "backgrounds/wrecking-crew/bg", -160 * 3, -81 * 3 + 3)
		setScrollFactor("bg", 1, 1)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)
	end

	-- background shit
	makeAnimatedLuaSprite("bomb", "backgrounds/wrecking-crew/bomb", 9 * 6, 25 * 6)
	addAnimationByIndices("bomb", "idle", "anim", "0", 12)
	addAnimationByPrefix("bomb", "boom", "anim", 12, false)
	setScrollFactor("bomb", 1, 1)
	setProperty("bomb.antialiasing", false)
	scaleObject("bomb", 6, 6)
	addLuaSprite("bomb", false)

	makeAnimatedLuaSprite("bomb2", "backgrounds/wrecking-crew/bomb", 81 * 6, 25 * 6)
	addAnimationByIndices("bomb2", "idle", "anim", "0", 12)
	addAnimationByPrefix("bomb2", "boom", "anim", 12, false)
	setScrollFactor("bomb2", 1, 1)
	setProperty("bomb2.antialiasing", false)
	scaleObject("bomb2", 6, 6)
	addLuaSprite("bomb2", false)
end

function onCreatePost()
	if week == "funkMix" or week == "funkMixDX" then
		setProperty("gf.visible", false)
	end
end

function onUpdate()
	if getTextString("isPaused") ~= "true" then
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("bomb.animation.curAnim.paused", false)
			setProperty("bomb2.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("bomb.animation.curAnim.paused", true)
			setProperty("bomb2.animation.curAnim.paused", true)
		end
	end
end