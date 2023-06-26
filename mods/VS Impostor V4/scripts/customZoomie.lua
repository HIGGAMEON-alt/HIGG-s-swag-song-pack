local realCamZoomie = true
local camBopIntensity = 1
local camBopInterval = 4
-- uses onStepHit, meaning it can hit smaller than beats. 0.25 is one step

local camTwistIntensity = 0
local camTwistIntensity2 = 3
local camTwist = false
local twistAmount = 1
local twistCrap = 1
local extraZoom = 0
-- gotta stay pg somehow

curZoom = 1

local noPreZoom = { -- probably should have made a preZoom var instead... maybe later
    ['sussus-moogus'] = true,
    ['sabotage'] = true,
    ['meltdown'] = true,
    ['sussus-toogus'] = true,
    ['lights-down'] = true,
    ['reactor'] = true,
    ['ejected'] = true,
    ['sauces moogus'] = true,
    defeat = true,
    ['top-10'] = true
}

function onCreate()
    -- initSaveData('backupPrefs', 'vsimpostorpsych')
    -- realCamZoomie = getPropertyFromClass('ClientPrefs', 'camZooms') too buggy, causes the pref to get stuck at false sometimes
    realCamZoomie = true
    curZoom = getProperty('defaultCamZoom')
    setPropertyFromClass('ClientPrefs', 'camZooms', false)
end

function onCreatePost()
    if not noPreZoom[string.lower(songName)] then
        onEvent('Add Camera Zoom', 0.22, 0)
    end
end

function onDestroy()
    setPropertyFromClass('ClientPrefs', 'camZooms', realCamZoomie)
end

function onStepHit()
    beatStep()
    if camTwist then
        if curStep % 4 == 0 then
            doTweenY('beatTwistHUD', 'camHUD', -6 * camTwistIntensity2, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'circout')
            doTweenY('beatTwistGame', 'camGame.scroll', 12, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        elseif curStep % 4 == 2 then
            doTweenY('beatTwistHUD', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenY('beatTwistGame', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        end
    end
end

function beatStep()
    if curStep % (camBopInterval * 4) == 0 and getProperty('camZooming') then
        onEvent('Add Camera Zoom', 0.015 * getProperty('camZoomingMult') * camBopIntensity, 0.03 * getProperty('camZoomingMult') * camBopIntensity)
    end
end

function onBeatHit()
    if camTwist then
        if curBeat % 2 == 0 then
            twistShit = twistAmount
        else
            twistShit = 0-twistAmount
        end
        setProperty('camHUD.angle', twistCrap * camTwistIntensity2)
        setProperty('camGame.angle', twistCrap * camTwistIntensity2)
        doTweenAngle('beatTwistHUD3', 'camHUD', twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'circout')
        doTweenX('beatTwistHUD4', 'camHUD', 0-twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'linear')
        doTweenAngle('beatTwistGame3', 'camGame', twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'circout')
        doTweenX('beatTwistGame4', 'camGame', 0-twistCrap * camTwistIntensity, getPropertyFromClass('Conductor', 'stepCrochet') * 0.001, 'linear')
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Camera Twist' then
        camTwist = true
        camTwistIntensity = tonumber(value1)
        camTwistIntensity2 = tonumber(value2)
        if value1 == nil or value1 == '' then camTwistIntensity = 0 end
        if value2 == nil or value2 == '' then camTwistIntensity2 = 0 end
        if camTwistIntensity2 == 0 then
            camTwist = false
            cancelTween('beatTwistGame4')
            cancelTween('beatTwistHUD4')
            doTweenX('beatTwistHUD3', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenX('beatTwistGame3', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenAngle('beatTwistHUD2', 'camHUD', 0, 1, 'sineinout')
            doTweenAngle('beatTwistGame2', 'camGame', 0, 1, 'sineinout')
            doTweenY('beatTwistHUD', 'camHUD', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
            doTweenY('beatTwistGame', 'camGame.scroll', 0, getPropertyFromClass('Conductor', 'stepCrochet') * 0.002, 'sinein')
        end
    end
    if eventName == 'Alter Camera Bop' then
        camBopIntensity = tonumber(value1)
        camBopInterval = tonumber(value2)
        if value1 == nil or value1 == '' then camBopIntensity = 1 end
        if value2 == nil or value2 == '' then camBopInterval = 4 end
        beatStep()
    end
    if eventName == 'Add Camera Zoom' then
        if realCamZoomie and curZoom < 1.35 then
            local camZoom = tonumber(value1)
            local hudZoom = tonumber(value2)
            if value1 == nil or value1 == '' then camZoom = 0.015 end
            if value2 == nil or value2 == '' then hudZoom = 0.03 end
            curZoom = curZoom + camZoom
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + hudZoom)
        end
    end
    if eventName == 'Camera Follow Pos' then -- mid focus, not in original mod but funni !!
        if value1 == 'mid' or value1 == 'middle' then
            cameraSetTarget('boyfriend')
            local boyCamPos = {getProperty('camFollow.x'), getProperty('camFollow.y')}
            cameraSetTarget('dad')
            local dadCamPos = {getProperty('camFollow.x'), getProperty('camFollow.y')}
            local midCamPos = {(boyCamPos[1] + dadCamPos[1]) / 2, (boyCamPos[2] + dadCamPos[2]) / 2}
            setProperty('camFollow.x', midCamPos[1])
            setProperty('camFollow.y', midCamPos[2])
            setProperty('isCameraOnForcedPos', true)
        end
    end
    if eventName == 'Extra Cam Zoom' then
        extraZoom = tonumber(value1) or 0
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - oldExtra + extraZoom)
    end
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function lerp(from,to,i)
	return from+(to-from)*i
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function onUpdate(elapsed)
    setPropertyFromClass('flixel.FlxG', 'camera.zoom', curZoom)
end

function onUpdatePost(elapsed)
    if getProperty('camZooming') then
        curZoom = lerp(getProperty('defaultCamZoom') + extraZoom, curZoom, boundTo(1-(elapsed * 3.125 * getProperty('camZoomingDecay') * playbackRate), 0, 1))
        setPropertyFromClass('flixel.FlxG', 'camera.zoom', curZoom)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setProperty('camZooming', true)
end

function opponentNoteHit()
    setPropertyFromClass('ClientPrefs', 'camZooms', true)
end