function changeCharSkin(isP1, note, splash)
	for daStrum, index in propFromGroup(isP1 and 'playerStrums' or 'opponentStrums') do
		daStrum.set('texture', 'notes/' .. note)
	end
	for index, value in pairs({'notes', 'unspawnNotes'}) do
		for daNote, index in propFromGroup(value) do
			if daNote.get('mustPress') == isP1 then
				daNote.set('texture', 'notes/' .. note)
				daNote.set('noteSplashTexture', 'notes/splashes/' .. splash)
			end
		end
	end
end

function onCreatePost()
	if dadName == 'kapi' or dadName == 'kapi-mad' then
		changeCharSkin(false, 'KAPI_assets', 'kapiSplashes')
	elseif dadName == 'g&w' then
		changeCharSkin(false, 'G&W_assets', 'g&wSplashes')
	end
	
	if boyfriendName == 'kapi-pixel' then
		changeCharSkin(true, 'KAPI_assets', 'kapiSplashes')
	end
end

-- function from Mayo78
function propFromGroup(object)
	local index = -1
	return function()
		index = index + 1
		if index < getProperty(object .. '.length') then
			local func = {}
			function func.get(property) --no colons cause it doesnt need to reference itself
				return getPropertyFromGroup(object, index, property)
			end
			function func.set(property, value)
				setPropertyFromGroup(object, index, property, value)
			end
			return func, index
		end
	end
end