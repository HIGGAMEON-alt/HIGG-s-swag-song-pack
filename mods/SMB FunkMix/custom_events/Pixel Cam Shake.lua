function onCreatePost()
	ogGameX = getProperty('camGame.x')
	ogHudX = getProperty('camHUD.x')
	if getDataFromSave("playerSettings", "showBorder") == true then
		ogBorderX = getProperty('border.x')
	else
		ogBorderX = getPropertyFromClass("openfl.Lib", "application.window.x")
	end
end

function onEvent(n, v1, v2)
	if week ~= "funkMixMX" then
		duration = tonumber(v2)
		intensityTable = mysplit(v1, ',')
		if n == 'Pixel Cam Shake' then
			runTimer('shakeGAME', duration, intensityTable[1])
			runTimer('shakeHUD', duration, intensityTable[2])
			runTimer('shakeBOR', duration, intensityTable[3])
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'shakeGAME' then
		if loopsLeft % 2 == 0 then
			setProperty('camGame.x', ogGameX + loopsLeft * 6)
		else
			setProperty('camGame.x', ogGameX - loopsLeft * 6)
		end
	end
	
	if tag == 'shakeHUD' then
		if loopsLeft % 2 == 0 then
			setProperty('camHUD.x', ogHudX + loopsLeft * 6)
		else
			setProperty('camHUD.x', ogHudX - loopsLeft * 6)
		end
	end
	
	if tag == 'shakeBOR' then
		if getDataFromSave("playerSettings", "showBorder") == true then
			if loopsLeft % 2 == 0 then
				setProperty('border.x', ogBorderX + loopsLeft * 6)
			else
				setProperty('border.x', ogBorderX - loopsLeft * 6)
			end
		else
			if loopsLeft % 2 == 0 then
				setPropertyFromClass("openfl.Lib", "application.window.x", ogBorderX + loopsLeft * 6)
			else
				setPropertyFromClass("openfl.Lib", "application.window.x", ogBorderX - loopsLeft * 6)
			end
		end
	end
end

function mysplit (inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		num = tonumber(str)
		table.insert(t, num)
   end
   return t
end