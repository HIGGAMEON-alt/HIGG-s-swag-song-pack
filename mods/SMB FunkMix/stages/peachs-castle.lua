function onCreate()
	addLuaScript("scripts/extra/Default Font")

	makeLuaSprite("bg", "backgrounds/peachs-castle/bg", -160 * 3, -81 * 3)
	setScrollFactor("bg", 1, 1)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)
end