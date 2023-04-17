function onCreatePost() 

	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')

	makeLuaSprite('bg','bg/prize counter/Background', -550,-580)
	scaleObject('bg', 1.1, 1.05)
	updateHitbox('bg')
	setProperty('bg.antialiasing', false)
	addLuaSprite('bg',false)


	makeLuaSprite('fence','bg/prize counter/fence thingy idk', -550,-700)
	scaleObject('fence', 1.1, 1.05)
	updateHitbox('fence')
	setProperty('fence.antialiasing', false)
	addLuaSprite('fence',false)


	setObjectOrder('gfGroup', getObjectOrder('fence'))
	--close(true)

end