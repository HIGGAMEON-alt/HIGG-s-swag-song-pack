function onStepHit()
   	if difficultyName == 'hard' then
		if curStep == 128 then
		    setProperty('health', -500);
		end
	end
	
	if difficultyName == 'hard' then
		if curStep == 127 then
		    playAnim('dad', 'hey');
			playSound('SNIPER RIFEL');
		end
	end
end