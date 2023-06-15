function onCreate()
    if flashingLights then
		moveMult = 1
	else
		moveMult = 0.5
	end	
end

function onCountdownStarted()
    for i = 0,getProperty("opponentStrums.length")-1 do
        _G['defaultOpponentStrumX'..i] = getPropertyFromGroup("opponentStrums", i, "x")
        _G['defaultOpponentStrumY'..i] = getPropertyFromGroup("opponentStrums", i, "y")
    end
    for i = 0,getProperty("playerStrums.length")-1 do
        _G['defaultPlayerStrumX'..i] = getPropertyFromGroup("playerStrums", i, "x")
        _G['defaultPlayerStrumY'..i] = getPropertyFromGroup("playerStrums", i, "y")
    end
end

function onUpdate(elapsed)
    local currentBeat = (getSongPosition() / 1000)*(bpm/84)
    if (curStep >= 384 and curStep < 1024) or (curStep >= 1280 and curStep < 2196) then
        if difficulty >= 1 then
            for i=0,getProperty("opponentStrums.length")-1 do
                setPropertyFromGroup("opponentStrums", i, "x", _G['defaultOpponentStrumX'..i] + (5*difficulty * math.sin((currentBeat + i*0.25) * math.pi)) * moveMult)
            end
            for i=0,getProperty("playerStrums.length")-1 do
                setPropertyFromGroup("playerStrums", i, "x", _G['defaultPlayerStrumX'..i] + (5*difficulty * math.sin((currentBeat + i*0.25) * math.pi)) * moveMult)
            end
        end
    end
    if difficulty >= 2 then
        if (curStep >= 384 and curStep < 1024) or (curStep >= 1280 and curStep < 2196) then
            setProperty("camGame.angle", (2.5*(difficulty-1) * math.sin((currentBeat + 0.25) * math.pi) * moveMult))
            setProperty("camHUD.angle", (2.5*(difficulty-1) * math.sin((currentBeat + 0.25) * math.pi) * moveMult))
            setProperty("camOther.angle", (2.5*(difficulty-1) * math.sin((currentBeat + 0.25) * math.pi) * moveMult))
        else
            setProperty("camGame.angle", 0)
            setProperty("camHUD.angle", 0)
            setProperty("camOther.angle", 0)
        end
    end
end