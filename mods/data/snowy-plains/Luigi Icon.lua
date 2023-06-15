function onCreate()
	initSaveData("playerSettings", "funkmixadvance")

	makeLuaSprite("iconLuigi", "icons/idle-luigi", getProperty("iconP2.x"), getProperty("iconP2.y"))
	setObjectCamera("iconLuigi", "hud")
	addLuaSprite("iconLuigi", true)
	setObjectOrder("iconLuigi", getObjectOrder("iconP2") + 1)
	setProperty("iconLuigi.flipX", false)
	setProperty("iconLuigi.visible", false)
	setProperty("iconLuigi.alpha", healthBarAlpha)
end

function onUpdate()
	if getProperty("health") > 1.6 then
		loadGraphic("iconLuigi", "icons/lose-luigi")
	else
		loadGraphic("iconLuigi", "icons/idle-luigi")
	end
end

function onUpdatePost()
	setProperty("iconLuigi.x", getProperty("iconP2.x") - 5)
	setProperty("iconLuigi.y", getProperty("iconP2.y") - 5)
	setProperty("iconLuigi.scale.x", getProperty("iconP2.scale.x"))
	setProperty("iconLuigi.scale.y", getProperty("iconP2.scale.y"))
	setProperty("iconLuigi.angle", getProperty("iconP2.angle"))
	setObjectOrder("iconLuigi", getObjectOrder("iconP2") + 1)
	
	if getPropertyFromClass("PlayState", "isPixelStage") then
		setProperty("iconLuigi.antialiasing", false)
	end

	if getPropertyFromClass("ClientPrefs", "hideHud") or getDataFromSave("playerSettings", "powerUpHP") then
		setProperty("iconLuigi.visible", false)
	end
end