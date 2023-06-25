local offX = -1000/2;
local offY = -500/2;
local graphic
--[[
FNF online image detector
makeLuaSprite('e','stage1/ground',0,0)
]]

function onCreate(stage, foreground)
	if not lowQuality then
		makeLuaSprite("cave", "stage1/cave", offX + 711, offY + 25)
		setScrollFactor("cave",0.8, 0.75);
		addLuaSprite("cave")
	end

	graphic = "stage1/ground"
	
	makeLuaSprite("ground", graphic,offX, offY + 710)
	addLuaSprite("ground")
	setScrollFactor(1, 0.95);
	addLuaSprite("ground")
	
	makeLuaSprite("mground",graphic, getProperty("ground.x") - getProperty("ground.width"), getProperty("ground.y"))
	addLuaSprite("mground")
	setProperty("mground.flipX",true)
	addLuaSprite("mground")
end