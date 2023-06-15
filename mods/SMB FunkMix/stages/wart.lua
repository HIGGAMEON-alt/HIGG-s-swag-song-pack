local xx = 160 * 3
local yy = 81 * 3

function funkMixCam()
	return week == "funkMix" or week == "funkMixDX" or getDataFromSave("playerSettings", "funkMixCam") == true
end

function onCreate()
	addLuaScript("scripts/extra/Default Font")

	makeLuaSprite("bg", "backgrounds/wart/bg", -400*3, -240*3)
	setScrollFactor("bg", 1, 1)
	setProperty("bg.antialiasing", false)
	scaleObject("bg", 6, 6)
	addLuaSprite("bg", false)
end

function onUpdatePost()
	-- Debug View
	-- triggerEvent("Camera Follow Pos",xx,yy)
	-- setProperty('camGame.zoom', 0.5)
	if funkMixCam() then
		triggerEvent("Camera Follow Pos",176*3-1,14*3-1)
	end
end