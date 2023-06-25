function onCreatePost()
    setPropertyFromClass('GameOverSubstate', 'characterName', 'genericdeath');
    
    --Teratoma
    if songName == 'teratoma' then
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameoverr_teratoma');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameover_endd_teratoma');
	end
	
	--Week1
	if songName == 'sussus-bloogus' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameoverr_week1');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameoverr_end_week1');
	elseif songName == 'apprehensive' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameoverr_week1');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameoverr_end_week1');
	elseif songName == 'fear' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameoverr_week1');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameoverr_end_week1');
	elseif songName == 'catastrophe' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameoverr_week1');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameoverr_end_week1');
	end
	
	--horsus
	if songName == 'sussus-horsus' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'game_overrrr_horse');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'game_over_end_horse');
	elseif songName == 'horsus-moogus' then
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'game_overrrr_horse');
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'game_over_end_horse');
	end
end

