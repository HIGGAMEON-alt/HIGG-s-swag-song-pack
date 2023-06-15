function onCreate()
	addLuaScript("scripts/extra/Default Font")

	makeLuaSprite("sky", "backgrounds/barrel-volcano/sky", -160 * 3, -81 * 3 + 3)
	setScrollFactor("sky", 1, 1)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

	makeLuaSprite("lavaBG", "backgrounds/barrel-volcano/lava", -160 * 3, -81 * 3 + 3)
	setScrollFactor("lavaBG", 0.75, 1)
	setProperty("lavaBG.antialiasing", false)
	scaleObject("lavaBG", 6, 6)
	addLuaSprite("lavaBG", false)
		
	makeLuaSprite("background", "backgrounds/barrel-volcano/background", -160 * 3, -81 * 3 + 3)
	setScrollFactor("background", 0.75+0.125, 1)
	setProperty("background.antialiasing", false)
	scaleObject("background", 6, 6)
	addLuaSprite("background", false)
		
	makeLuaSprite("ground", "backgrounds/barrel-volcano/ground", -160 * 3, -81 * 3 + 3)
	setScrollFactor("ground", 1, 1)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)

	makeLuaSprite("raft", "backgrounds/barrel-volcano/raft", -160 * 3, -81 * 3 + 3)
	setScrollFactor("raft", 1, 1)
	setProperty("raft.antialiasing", false)
	scaleObject("raft", 6, 6)
	addLuaSprite("raft", false)

	makeLuaSprite("lavaFG", "backgrounds/barrel-volcano/lava", -160 * 3, -81 * 3 + 3 + (6*6))
	setScrollFactor("lavaFG", 1, 1)
	setProperty("lavaFG.antialiasing", false)
	scaleObject("lavaFG", 6, 6)
	addLuaSprite("lavaFG", false)
end