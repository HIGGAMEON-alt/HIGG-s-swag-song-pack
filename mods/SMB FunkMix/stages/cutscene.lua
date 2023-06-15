function onCreate()
	addLuaScript("scripts/extra/menus/Cutscene")
	setProperty("camGame.visible", false)
	setProperty("camHUD.visible", false)
end

function onGameOver()
	return Function_Stop
end