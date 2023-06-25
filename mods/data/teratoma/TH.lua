function onCreatePost()
    middle = getPropertyFromClass('ClientPrefs', 'middleScroll')
	if middle == false then
		for i = 0,7 do
			xValue = getPropertyFromGroup('strumLineNotes', i, 'x')
			if i < 3.5 then
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue+9999)
			else
				setPropertyFromGroup('strumLineNotes', i, 'x', xValue-600)
			end
		end
	end
end



function onCreatePost()
        setTextColor('scoreTxt','884709')
    end
function onStepHit()
        if curStep == 260 then
    runTimer('dodge', 0.1);  
end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'dodge' then
    if keyPressed('space') then
        -- characterPlayAnim('boyfriend', 'dodge', true);
    else
        setProperty('health', -100);
    end
end
end