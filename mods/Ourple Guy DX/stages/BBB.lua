function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('backstage','bg/ONaF office', 0, 0)
	scaleObject('backstage', 2.2, 2.2)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	close(true)
end