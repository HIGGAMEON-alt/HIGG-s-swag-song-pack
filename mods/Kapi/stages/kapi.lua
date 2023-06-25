function onCreate()
	makeLuaSprite('bg', 'stages/arcade', -600, -200)
	setScrollFactor('bg', 0.9, 0.9)

	makeLuaSprite('platform', 'stages/somethingplatform', -580, 600)
	setScrollFactor('platform', 0.9, 0.9)
	scaleObject('platform', 1.1, 1)

	makeLuaSprite('light', 'stages/lighting/win0', -600, -200)
	setScrollFactor('light', 0.9, 0.9)

	if songName == 'Beathoven' then
		makeLuaSprite('bg', 'stages/arcade2', -600, -200)
		makeAnimatedLuaSprite('skid', 'stages/skidwha', 25, 200)
		addAnimationByPrefix('skid', 'bop', 'Bottom Level Boppers', 24, true)
		setScrollFactor('skid', 0.9, 0.9)
	end
	
	addLuaSprite('bg', false)
	addLuaSprite('skid', false)
	addLuaSprite('platform', false)
	addLuaSprite('light', false)
end