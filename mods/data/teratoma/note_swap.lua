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