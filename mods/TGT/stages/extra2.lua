function onCreate()
	makeLuaSprite("ground", "extra2/ground", -600, 450)
	addLuaSprite("ground")
	setProperty("ground.x", getProperty("ground.x") - getProperty("ground.width") * 0.25)
	setProperty("ground.scale.x", 1.5)
	updateHitbox("ground", true)

	makeLuaSprite("back", "extra2/back", -550, getProperty("ground.y") - 148)
	addLuaSprite("back")
	setScrollFactor("back", 0.7, 0.7)
end