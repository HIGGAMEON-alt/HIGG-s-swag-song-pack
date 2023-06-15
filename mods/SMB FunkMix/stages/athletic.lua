enemyX = 0
enemyY = 0
local ogX = 0
local ogY = 0
flipped = 1

function onCreate()
	if week ~= "funkMix" and week ~= "funkMixDX" then
		addLuaScript("scripts/extra/fonts/Lost Levels Font")
	else
		addLuaScript("scripts/extra/fonts/Default Font")
	end

	if not lowQuality and week ~= "funkMixDX" then
		makeLuaSprite("sky", "backgrounds/athletic/sky", -160 * 3, -81 * 3 + 3)
		setScrollFactor("sky", 1, 1)
		setProperty("sky.antialiasing", false)
		scaleObject("sky", 6, 6)
		addLuaSprite("sky", false)

		makeLuaSprite("background", "backgrounds/athletic/background", -160 * 7/3, -81 * 3)
		setScrollFactor("background", 1/3, 1)
		setProperty("background.antialiasing", false)
		scaleObject("background", 6, 6)
		addLuaSprite("background", false)

		makeAnimatedLuaSprite("water2", "backgrounds/athletic/water2", -160 * 8/3, -81 * 2.5 + 3)
		addAnimationByPrefix("water2", "anim", "anim0", 9, true)
		setScrollFactor("water2", 2/3, 1)
		setProperty("water2.antialiasing", false)
		scaleObject("water2", 6, 6)
		addLuaSprite("water2", false)

		makeLuaSprite("ground", "backgrounds/athletic/ground", -160 * 3, -81 * 3 + 3)
		setScrollFactor("ground", 1, 1)
		setProperty("ground.antialiasing", false)
		scaleObject("ground", 6, 6)
		addLuaSprite("ground", false)

		makeAnimatedLuaSprite("water", "backgrounds/athletic/water", -160 * 10/3, -81 * 3 + 3)
		addAnimationByPrefix("water", "anim", "anim0", 9, true)
		setScrollFactor("water", 4/3, 1)
		setProperty("water.antialiasing", false)
		scaleObject("water", 6, 6)
		addLuaSprite("water", true)
	else
		makeLuaSprite("bg", "backgrounds/athletic/athletic", -160 * 3, -81 * 3 + 3)
		setScrollFactor("bg", 1, 1)
		setProperty("bg.antialiasing", false)
		scaleObject("bg", 6, 6)
		addLuaSprite("bg", false)

		makeLuaSprite("ground", "backgrounds/athletic/ground", -160 * 3, -81 * 3 + 3)
		setScrollFactor("ground", 1, 1)
		setProperty("ground.antialiasing", false)
		scaleObject("ground", 6, 6)
		addLuaSprite("ground", false)

		makeAnimatedLuaSprite("water", "backgrounds/athletic/water", -160 * 3, -81 * 3 + 3)
		addAnimationByPrefix("water", "anim", "anim0", 9, true)
		setScrollFactor("water", 1, 1)
		setProperty("water.antialiasing", false)
		scaleObject("water", 6, 6)
		addLuaSprite("water", true)
	end

	makeAnimatedLuaSprite("enemy", "backgrounds/athletic/enemy", 172 * 6, -18 * 6)
	addAnimationByPrefix("enemy", "koopa-red", "koopaRed0", 6, true)
	setScrollFactor("enemy", 1, 1)
	setProperty("enemy.antialiasing", false)
	scaleObject("enemy", 6, 6)
	addLuaSprite("enemy", false)

	enemyX = getProperty("enemy.x")
	enemyY = getProperty("enemy.y")
	ogX = getProperty("enemy.x")
	ogY = getProperty("enemy.y")
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if getProperty("enemy.flipX") == false then
			flipped = 1
		else
			flipped = -1
		end

		enemyX = enemyX - (1 * 130 * elapsed * flipped)
		if enemyX < (114 * 6) then
			setProperty("enemy.flipX", true)
		end

		if (getProperty("enemy.flipX") and enemyX > ogX) then
			setProperty("enemy.flipX", false)
		end
		
		setProperty("enemy.x", math.floor(enemyX / 6) * 6)
		setProperty("enemy.y", math.floor(enemyY / 6) * 6)

		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", false)
			setProperty("water.animation.curAnim.paused", false)
			setProperty("water2.animation.curAnim.paused", false)
		end
	else
		if isRunning("scripts/extra/menus/Pause") then
			setProperty("enemy.animation.curAnim.paused", true)
			setProperty("water.animation.curAnim.paused", true)
			setProperty("water2.animation.curAnim.paused", true)
		end
	end
end