function onCreatePost()
    for i = 0, getProperty('eventNotes.length') do
        if getPropertyFromGroup('eventNotes', i, 'event') == 'Change Splashes' then
            precacheImage(getPropertyFromGroup('eventNotes', i, 'value1'))
        end
    end
end

function onEvent(name, value1, value2)
	if name == 'Change Splashes' then
		if value1 ~= nil or value1 ~= '' then
			for i = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then
					setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', value1)
				end
			end
		end
	end
end