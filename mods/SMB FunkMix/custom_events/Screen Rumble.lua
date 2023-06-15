shakeTime = 2
shakeIntensity = 4
shakeOffset = 0
shakeDir = 1
nextShake = 0
doShake = false

function onEvent(name, value1, value2)
	if name == "Screen Rumble" then
		doShake = true

		if value1 == "" then
			shakeIntensity = 4
		else
			shakeIntensity = value1
		end

		if value2 == "" then
			shakeTime = 2
		else
			shakeTime = value2
		end
	end
end

function onUpdate(elapsed)
	if getTextString("isPaused") ~= "true" then
		if doShake == true and flashingLights then
			nextShake = nextShake - elapsed
			if nextShake <= 0 then
				shakeDir = -shakeDir
				nextShake = 0.025
			end

			if (shakeTime > 0 and flashingLights) then
				shakeTime = shakeTime - elapsed
				moveStrength = shakeIntensity * ((shakeTime / 2) + 1)

				shakeOffset = math.floor((shakeDir * moveStrength) / 6) * 6
				setProperty("camGame.y", shakeOffset)
				
				if shakeTime <= 0 then
					doShake = false
					shakeTime = 0
					shakeOffset = 0
					setProperty("camGame.y", 0)
					setProperty("camHUD.y", 0)
					if getProperty("dad.animation.name") == "explode" then
						setProperty("dad.visible", false)
					end
				end
			end
		end
	end
end