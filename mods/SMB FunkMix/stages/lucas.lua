function onCreate()
	addLuaScript("scripts/extra/Default Font")

	makeLuaSprite("sky", "", -160 * 3, -81 * 3)
	makeGraphic("sky", 320, 162, "9494ff")
	setScrollFactor("sky", 1, 1)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

	makeLuaSprite("ground", "backgrounds/lucas/ground", -160 * 3, -81 * 3)
	setScrollFactor("ground", 1, 1)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)

	makeLuaSprite("groundFake", "backgrounds/lucas/ground-facade", -160 * 3, -81 * 3)
	setScrollFactor("groundFake", 1, 1)
	setProperty("groundFake.antialiasing", false)
	scaleObject("groundFake", 6, 6)
	addLuaSprite("groundFake", false)
end