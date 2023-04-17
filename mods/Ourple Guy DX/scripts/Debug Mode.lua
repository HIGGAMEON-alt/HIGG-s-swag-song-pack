
local CamHUDhide = false
local CamOTHERhide = false
local TxT_Hide = false
local BF_show = true
local GF_show = true
local DAD_show = true
local DebugChar = false
local MovementImpact = 0
local SmollMovementImpact = 0
local CameraImpact = 0.000
local CAMTOGGLE = true
local MapGrabPositioning = {'boyfriend', 'dad', 'gf', 'bg', 'sky', 'ground'}
local MapGrabPositioningLength = 3
local paused = false
local songPos = 0
function onCreatePost()
    MAPGRABPOSITIONING.length = 3
    if getPropertyFromClass('PlayState', 'chartingMode') then
    makeLuaSprite('camtoggleveriable', null, 0, 0)
    addLuaSprite('camtogglevariable', false)
    setProperty('camtogglevariable.visible', false)
    makeLuaSprite('FakecamFollow', null, 0, 0)
    addLuaSprite('FakecamFollow', false)
    setProperty('FakecamFollow.visible', false)
	makeLuaText('DebugTxT', "", 234, getProperty('window.length'),  60)
	setTextSize('DebugTxT', 18);
	setTextFont('DebugTxT', '');
	setTextAlignment('DebugTxT', left);
	addLuaText('DebugTxT');
    setObjectCamera('DebugTxT', 'other');
    makeLuaText('charOffsX', "", 284, 560,  259)
	setTextSize('charOffsX', 32);
	setTextFont('charOffsX', '');
	setTextAlignment('charOffsX', left);
	addLuaText('charOffsX');
    setObjectCamera('charOffsX', 'other');
    makeLuaText('charOffsY', "", 284, 560,  295)
	setTextSize('charOffsY', 32);
	setTextFont('charOffsY', '');
	setTextAlignment('charOffsY', left);
	addLuaText('charOffsY');
    setObjectCamera('charOffsY', 'other');
    makeLuaText('charNames', "", 84, 520,  220)
	setTextSize('charNames', 32);
	setTextFont('charNames', '');
	setTextAlignment('charNames', left);
	addLuaText('charNames');
    setObjectCamera('charNames', 'other');
    makeLuaText('Camera', "Cam:", 100, 520,  350)
	setTextSize('Camera', 32);
	setTextFont('Camera', '');
	setTextAlignment('Camera', left);
	addLuaText('Camera');
    setObjectCamera('Camera', 'other');
    makeLuaText('CameraText', getProperty('defaultCamZoom'), 100, 610,  350)
	setTextSize('CameraText', 32);
	setTextFont('CameraText', '');
	setTextAlignment('CameraText', left);
	addLuaText('CameraText');
    setObjectCamera('CameraText', 'other');
    setProperty('Camera.alpha', 0)
    setProperty('CameraText.alpha', 0)

    setProperty('FakecamFollow.x', getProperty('camFollow.x'))
    setProperty('FakecamFollow.y', getProperty('camFollow.y'))
end
end

function onSongStart()
    if getPropertyFromClass('PlayState', 'chartingMode') then
        setTextString('DebugTxT', "cam move controls - J K I L cam zoom controls - Q E Bot play/ Cam control toggle - B Hide CamHUD toggle - 1 Hide CamOTHER toggle - 2 Press space to hide this BF show toggle - 3 DAD show toggle - 4 GF show toggle - 5  BF debug offset - CTRL 3 Dad debug offset - CTRL 4 GF debug offset - CTRL 5 Debug offset Move dad/gf/bf CONTROL+ARROW or SHIFT+ARROW or ARROW or CONTROL+SHIFT+ARROW");
    end
end


function onUpdatePost()
    if paused == false then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FIVE') then
        for i = 0, getProperty('notes.length') - 1 do
            setPropertyFromGroup('notes', getProperty('notes.length'), 'copyY', true)
        end
    paused = true
    end
    setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
    setPropertyFromClass('flixel.FlxG', 'state.transOut', false)
    end
    if paused == true then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX') then
    for i = 0, getProperty('notes.length') - 1 do
        setPropertyFromGroup('notes', getProperty('notes.length'), 'copyY', false)
    end
     songPos = getPropertyFromClass('Conductor', 'songPosition')
    paused = false
    end
    setPropertyFromClass('Conductor','songPosition', songPos)
    setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
    setPropertyFromClass('flixel.FlxG', 'state.transOut', true)
    end
if CAMMOVEDETECTOR == false then
    setProperty('camtogglevariable.y', 0)
    setProperty('FakecamFollow.x', getProperty('camFollow.x'))
    setProperty('FakecamFollow.y', getProperty('camFollow.y'))
end
if CAMMOVEDETECTOR == true then
    setProperty('camtogglevariable.y', 1)
    triggerEvent('Camera Follow Pos', getProperty('FakecamFollow.x'), getProperty('FakecamFollow.y'))
end
if getPropertyFromClass('PlayState', 'chartingMode') then
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') and CAMTOGGLE == false then
    setProperty('Camera.alpha', 0)
    setProperty('CameraText.alpha', 0)
    CAMTOGGLE = true
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') and CAMTOGGLE == true then
        setProperty('Camera.alpha', 100)
        setProperty('CameraText.alpha', 100)
        CAMTOGGLE = false
    elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.Q') then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.030)
        doTweenZoom('d', 'camGame', getProperty('defaultCamZoom') + 0.1 -CameraImpact, 0.08, 'linear')
        setTextString('CameraText', getProperty('defaultCamZoom'))
        MovementImpact = MovementImpact -0.5
        CameraImpact= CameraImpact -0.001
        SmollMovementImpact = SmollMovementImpact -0.1
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.E') then
    setTextString('CameraText', getProperty('defaultCamZoom'))
    setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.030)
    doTweenZoom('d', 'camGame', getProperty('defaultCamZoom') - 0.1 +CameraImpact, 0.08, 'linear')
    MovementImpact = MovementImpact +0.5
    CameraImpact= CameraImpact +0.001
    SmollMovementImpact = SmollMovementImpact +0.1
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') +50 -MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') -50 +MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') + 10 -SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') - 10 +SmollMovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 50 +MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') - 50 -MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 10 +SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') - 10 +SmollMovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.K') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') + 10 -SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 10 -SmollMovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.K') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') + 50 -MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 50 -MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.K') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 50 +MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 50 -MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 10 +SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 10 -SmollMovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x'))
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') - 50 +MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.I') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x'))
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') - 10)
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 50 +MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y'))
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.J') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') - 10 +SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y'))
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') + 50 -MovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y'))
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.L') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x') + 10 -SmollMovementImpact)
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y'))
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.K') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x'))
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 50 -MovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.K') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') then
    setProperty('FakecamFollow.x', getProperty('FakecamFollow.x'))
    setProperty('FakecamFollow.y', getProperty('FakecamFollow.y') + 10 -SmollMovementImpact)
    CAMMOVEDETECTOR = true
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.O') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    CAMMOVEDETECTOR = false
    triggerEvent('Camera Follow Pos', '', '')
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.B') then
        setProperty('cpuControlled', false)
        setProperty('botplayTxt.visible', false)
elseif not getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.B') then
            setProperty('cpuControlled', true)
            setProperty('botplayTxt.visible', true)
elseif CamHUDhide == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ONE') then
    setProperty('botplayTxt.visible', false)
	doTweenAlpha('GUItween', 'camHUD', 0, 0.05, 'linear');
    CamHUDhide = true
elseif CamHUDhide == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ONE') then
    setProperty('botplayTxt.visible', true)
    doTweenAlpha('GUItween', 'camHUD', 1, 0.05, 'linear');
    CamHUDhide = false
elseif CamOTHERhide == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TWO') then
	doTweenAlpha('GUItween', 'camOther', 0, 0.05, 'linear');
    CamOTHERhide = true
elseif CamOTHERhide == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TWO') then
    doTweenAlpha('GUItween', 'camOther', 1, 0.05, 'linear');
    CamOTHERhide = false
elseif TxT_Hide == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
    TxT_Hide = false
    setTextString('DebugTxT', "cam move controls - J K I L cam zoom controls - Q E Bot play/ Cam control toggle - B Hide CamHUD toggle - 1 Hide CamOTHER toggle - 2 Press space to hide this BF show toggle - 3 DAD show toggle - 4 GF show toggle - 5  BF debug offset - CTRL 3 Dad debug offset - CTRL 4 GF debug offset - CTRL 5 Debug offset Move dad/gf/bf CONTROL+ARROW or SHIFT+ARROW or ARROW or CONTROL+SHIFT+ARROW");
elseif TxT_Hide == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
    TxT_Hide = true
    debugPrint("Text Hidden!")
    debugPrint("Press space to show again")
    setTextString('DebugTxT', "");
elseif BF_show == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.THREE') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriendGroup.visible', false)
    BF_show = false
elseif BF_show == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.THREE') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriendGroup.visible', true)
    BF_show = true
elseif BF_show == true and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FOUR') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dadGroup.visible', false)
    DAD_show = false
elseif BF_show == false and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FOUR') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and MapGrabPositioning.number == MapGrabPositioning.length then
    MapGrabPositioning.number = 1
    BF_show = true

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.THREE') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setTextString('charOffsX', getProperty(MapGrabPositioning[MapGrabPositioning.number]..'.x'))
    setTextString('charOffsY', getProperty(MapGrabPositioning[MapGrabPositioning.number]..'.y'))
    setTextString('charNames', '    X:    Y:')
    DebugChar = MapGrabPositioning[MapGrabPositioning.length]
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.O') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setTextString('charOffsX', '')
    setTextString('charOffsY', '')
    setTextString('charNames', '')
    DebugChar = false
end

--this part of the code is a slop of mess so I'll seperate and say which one is mean for who
--BF's char offsets

--diagnal BF offs
if getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == MapGrabPositioning[MapGrabPositioning.length] and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y', getProperty('boyfriend.y')-10)
    setTextString('charOffsY', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y'))
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x')+10)
    setTextString('charOffsX', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y')-10)
    setTextString('charOffsY', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y'))
    getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x')-10)
    setTextString('charOffsX', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y')+10)
    setTextString('charOffsY', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y'))
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x')+10)
    setTextString('charOffsX', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y', getProperty('boyfriend.y')+10)
    setTextString('charOffsY', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.y'))
    setProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x')-10)
    setTextString('charOffsX', getProperty(MapGrabPositioning[MapGrabPositioning.length]..'.x'))

--straight line BF offs
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')-1)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')-10)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')-50)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')-10)
    setTextString('charOffsX', getProperty('boyfriend.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')+1)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')+10)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')+50)
    setTextString('charOffsX', getProperty('boyfriend.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.x', getProperty('boyfriend.x')+10)
    setTextString('charOffsX', getProperty('boyfriend.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')-1)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')-10)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')-50)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')-10)
    setTextString('charOffsY', getProperty('boyfriend.y'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')+1)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'boyfriend' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')-10)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')+50)
    setTextString('charOffsY', getProperty('boyfriend.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'boyfriend' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('boyfriend.y', getProperty('boyfriend.y')+10)
    setTextString('charOffsY', getProperty('boyfriend.y'))





--diagnal DAD offs
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty('dad.y', getProperty('dad.y')-10)
    setTextString('charOffsY', getProperty('dad.y'))
    setProperty('dad.x', getProperty('dad.x')+10)
    setTextString('charOffsX', getProperty('dad.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty('dad.y', getProperty('dad.y')-10)
    setTextString('charOffsY', getProperty('dad.y'))
    setProperty('dad.x', getProperty('dad.x')-10)
    setTextString('charOffsX', getProperty('dad.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty('dad.y', getProperty('dad.y')+10)
    setTextString('charOffsY', getProperty('dad.y'))
    setProperty('dad.x', getProperty('dad.x')+10)
    setTextString('charOffsX', getProperty('dad.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty('dad.y', getProperty('dad.y')+10)
    setTextString('charOffsY', getProperty('dad.y'))
    setProperty('dad.x', getProperty('dad.x')-10)
    setTextString('charOffsX', getProperty('dad.x'))

--straight line DAD offs
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')-1)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')-10)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')-50)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')-10)
    setTextString('charOffsX', getProperty('dad.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')+1)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')+10)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')+50)
    setTextString('charOffsX', getProperty('dad.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.x', getProperty('dad.x')+10)
    setTextString('charOffsX', getProperty('dad.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')-1)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')-10)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')-50)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')-10)
    setTextString('charOffsY', getProperty('dad.y'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')+1)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'dad' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')+10)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')+50)
    setTextString('charOffsY', getProperty('dad.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'dad' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('dad.y', getProperty('dad.y')+10)
    setTextString('charOffsY', getProperty('dad.y'))




--diagnal GF offs
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty('gf.y', getProperty('gf.y')-10)
    setTextString('charOffsY', getProperty('gf.y'))
    setProperty('gf.x', getProperty('gf.x')+10)
    setTextString('charOffsX', getProperty('gf.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty('gf.y', getProperty('gf.y')-10)
    setTextString('charOffsY', getProperty('gf.y'))
    setProperty('gf.x', getProperty('gf.x')-10)
    setTextString('charOffsX', getProperty('gf.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') then
    setProperty('gf.y', getProperty('gf.y')+10)
    setTextString('charOffsY', getProperty('gf.y'))
    setProperty('gf.x', getProperty('gf.x')+10)
    setTextString('charOffsX', getProperty('gf.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') then
    setProperty('gf.y', getProperty('gf.y')+10)
    setTextString('charOffsY', getProperty('gf.y'))
    setProperty('gf.x', getProperty('gf.x')-10)
    setTextString('charOffsX', getProperty('gf.x'))

--straight line GF offs
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')-1)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')-10)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')-50)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.LEFT') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')-10)
    setTextString('charOffsX', getProperty('gf.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')+1)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')+10)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')+50)
    setTextString('charOffsX', getProperty('gf.x'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.RIGHT') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.x', getProperty('gf.x')+10)
    setTextString('charOffsX', getProperty('gf.x'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')-1)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')-10)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.UP') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')-50)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.UP') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')-10)
    setTextString('charOffsY', getProperty('gf.y'))

elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')+1)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'gf' and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')+10)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.DOWN') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and not getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')+50)
    setTextString('charOffsY', getProperty('gf.y'))
elseif getProperty('cpuControlled') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.DOWN') and DebugChar == 'gf' and getPropertyFromClass('flixel.FlxG', 'keys.pressed.SHIFT') and getPropertyFromClass('flixel.FlxG', 'keys.pressed.CONTROL') then
    setProperty('gf.y', getProperty('gf.y')+10)
    setTextString('charOffsY', getProperty('gf.y'))
elseif MovementImpact > 45 then
    MovementImpact = 45
    elseif MovementImpact < -45 then
        MovementImpact = -45
    elseif SmollMovementImpact > 10 then
        SmollMovementImpact = 10
        elseif SmollMovementImpact < 1 then
            SmollMovementImpact = -1
end
end
end

--setProperty('iconP1.flipX', true)