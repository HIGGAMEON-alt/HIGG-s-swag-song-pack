local xx = 425.59
local yy = 529.03
local xx2 = 986.95
local yy2 = 526.99
local ofs = 50
local followchars = true


function onCreate()
    makeLuaSprite('bluesquare','',-400,-500)
	makeGraphic('bluesquare',2000,2000,'56c1fd')
	
    setScrollFactor('bartop',0,0)
	makeLuaSprite('bg', 'blomer/Sky Bg', -1000, -2200)
	setScrollFactor('bg', 0.6, 1)
	scaleObject('bg', 1, 1)
	
	makeLuaSprite('bushe', 'blomer/grass bg', -1200, -248)
	setScrollFactor('bushe', 0.9, 1)
	scaleObject('bushe', 1, 1)
	
	makeLuaSprite('mario1-1', 'blomer/layout bg', -1800, -600)
	setScrollFactor('mario1-1', 0.7, 1)
	scaleObject('mario1-1', 1, 1)
	
	makeLuaSprite('ground', 'blomer/Grass', -1500, -100)
	setScrollFactor('ground', 1, 1)
	scaleObject('ground', 1, 1)
	
	makeLuaSprite('sign', 'blomer/sign', 270, -135)
	setScrollFactor('sign', 1, 1)
	scaleObject('sign', 1, 1)
	

	addLuaSprite('bg', false)
	setProperty('bg.antialiasing',false)
	addLuaSprite('mario1-1', false)
	setProperty('mario1-1.antialiasing',false)
	addLuaSprite('bushe', false)
	setProperty('bushe.antialiasing',false)
	addLuaSprite('ground', false)
	setProperty('ground.antialiasing',false)
	addLuaSprite('sign', false)
	addLuaSprite('bluesquare',false)
	setProperty('bluesquare.alpha', 0)
end
