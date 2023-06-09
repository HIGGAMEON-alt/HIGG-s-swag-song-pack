function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

	makeLuaSprite("wall", "backgrounds/stage/stageBG1", -198, -68.5-4*6+2)
	setScrollFactor("wall", 0.75, 1)
	setProperty("wall.antialiasing", false)
	scaleObject("wall", 6, 6)
	addLuaSprite("wall")
	makeLuaSprite("floor", "backgrounds/stage/stageBG2", -198, -68.5-4*6+2)
	setProperty("floor.antialiasing", false)
	scaleObject("floor", 6, 6)
	addLuaSprite("floor")
	makeLuaSprite("curtains", "backgrounds/stage/stageBG3", -214, -68.5-4*6+2)
	setScrollFactor("curtains", 1.25, 1)
	setProperty("curtains.antialiasing", false)
	scaleObject("curtains", 6, 6)
	addLuaSprite("curtains", true)
end