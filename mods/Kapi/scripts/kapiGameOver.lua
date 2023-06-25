function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-kapi') --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx') --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver') --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd') --put in mods/music/
end

function onGameOver()
	runHaxeCode([[
		defaultCamZoom = 1;
	]])
	return Function_Continue
end