local batteryLoss = 0.01
local light_loss = {0.05,0.07,0,0.08,0}
local light_loss_recovery = {0.05,0.07,0,0.08,0}
local lightCycle = 0
local RBGLight = 255
function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeAnimatedLuaSprite('backstage','bg/FNaFOffice2/FNaF_2_BG', 0, -450)
	addAnimationByPrefix('backstage', 'e', 'bg', 30, false);
	objectPlayAnimation('backstage', 'e', true);
	scaleObject('backstage', 1.2, 1.2)
	updateHitbox('backstage')
	addLuaSprite('backstage',false)

	makeAnimatedLuaSprite('backstage2','bg/FNaFOffice2/FNaF_2_BG', 0, -450)
	addAnimationByPrefix('backstage2', 'e', 'bg', 30, false);
	objectPlayAnimation('backstage2', 'e', true);
	scaleObject('backstage2', 1.2, 1.2)
	updateHitbox('backstage2')
	addLuaSprite('backstage2',false)
	setBlendMode('backstage2', 'MULTIPLY')
	setProperty('backstage2.alpha', 0)

	makeAnimatedLuaSprite('lights','bg/FNaFOffice2/FNaF_2_BG', 100, -350)
	scaleObject('lights', 1.2, 1.2)
	updateHitbox('lights')
	addAnimationByPrefix('lights', 'e', 'ioverlay', 30, false);
	objectPlayAnimation('lights', 'e', true);
	addLuaSprite('lights',true)
	setBlendMode('lights', 'ADD')
	setProperty('lights.alpha', 0.8)
	--close(true)
end

function onUpdate()
if batteryLoss >= 1 then
light_loss = {0,0,0,0,0}
else
light_loss = light_loss_recovery
batteryLoss = batteryLoss + 0.0002
end
if getProperty('vocals.time') % 3 == 2 then
if lightCycle == 6 then
lightCycle = 1
else
lightCycle = lightCycle + 1
end
RBGLight = {light_loss[lightCycle], batteryLoss}
setProperty('lights.alpha', 1 - light_loss[lightCycle] - batteryLoss)
setProperty('backstage1.alpha', 1 - getProperty('lights.alpha'))
setProperty('backstage2.alpha', 0 + batteryLoss)
setProperty('backstage2.color', getColorFromHex(rgbToHex({255 - light_loss[lightCycle] - batteryLoss * 255 + 80, 255 - light_loss[lightCycle] - batteryLoss * 255 + 80, 255 - light_loss[lightCycle] - batteryLoss * 255 + 80})))
setProperty('boyfriend.color', RBGMathStuff())
setProperty('dad.color', RBGMathStuff())
setProperty('gf.color', RBGMathStuff())
end
end

function onEvent(n)
if n:lower() == 'change character' then
batteryLoss = 0
end
end

function RBGMathStuff()
return getColorFromHex(string.format('%02x%02x%02x', math.floor(255 - light_loss[lightCycle] - batteryLoss * 255 + 10), math.floor(255 - light_loss[lightCycle] - batteryLoss * 255 + 10), math.floor(255 - light_loss[lightCycle] - batteryLoss * 255 + 10)))
end

--[[
grabbed this from 💜 Rodney, Imaginative Person 💙
on the Psych Engine Server
]]
function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end
