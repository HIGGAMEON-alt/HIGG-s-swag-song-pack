local offX = -1912/2;
local offY = 536/2;

function onCreate()
	if not lowQuality then
	makeLuaSprite("back", "stage-tree/back", offX, offY)
	addLuaSprite("back")
	setScrollFactor("back",0.75,0.75)

	makeLuaSprite("mback", "stage-tree/back", offX, offY)
	addLuaSprite("mback")
	setScrollFactor("mback",0.75,0.75)
	setProperty("mback.x", offX + getProperty("mback.width"))
	setProperty("mback.flipX", true)
	end
	makeLuaSprite("ground", "stage-tree/ground", offX, offY + 120)
	addLuaSprite("ground")
	setScrollFactor("ground",1,0.95)
	
	makeLuaSprite("fground", "stage-tree/ground", offX, offY + 120)
	addLuaSprite("fground")
	setScrollFactor("fground",1,0.95)
	setProperty("mback.x", getProperty("back.x") + 2912)
	setProperty("mback.flipX", true)
	
	--[[var xground = new FlxSprite(fground.x, fground.y + fground.height).makeGraphic(1, 1, 0xFF23B14D);
	xground.setGraphicSize(fground.width * 3);
	xground.scrollFactor.set(1, 0.95);
	xground.updateHitbox();
	stage.add(xground);]]
	
	makeLuaSprite("tree", "stage-tree/tree", offX - 100, ofY - 782)
	addLuaSprite("tree")
	setScrollFactor("tree",0.95,0.95)
end