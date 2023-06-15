function onCreate()
	addLuaScript("scripts/extra/fonts/GameBoy Font")

	makeLuaSprite("bg", "", -160 * 3, -81 * 3)
	makeGraphic("bg", screenWidth*2, screenHeight*2, "0F380F")
	setScrollFactor("bg", 1, 1)
	addLuaSprite("bg", false)
end