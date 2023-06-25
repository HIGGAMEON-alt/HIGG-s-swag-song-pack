


function onEvent(name, value1, value2)
	if name == '0CS-camZoom' then
		if value1 == 'cam1bounce' then

		setProperty('camGame.zoom',getProperty('camGame.zoom')+0.1)
		setProperty('camHUD.zoom',getProperty('camHUD.zoom')+0.1)
			if songName == "Satanic Funkin'" then
				setProperty('camGame.zoom',getProperty('camGame.zoom')+0.0005)
				setProperty('camHUD.zoom',getProperty('camHUD.zoom')+0.0005)
			end

		else
			if value2 == '' then
				setProperty("defaultCamZoom", value1)
			else
				doTweenZoom('ocsCamZoom', 'camGame', value1, value2, 'sineInOut')
			end
		end
	end

end


function onTweenCompleted(name)

if name == 'ocsCamZoom' then


      	 setProperty("defaultCamZoom",getProperty('camGame.zoom')) 

end


end