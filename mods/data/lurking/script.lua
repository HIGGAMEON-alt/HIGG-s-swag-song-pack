function opponentNoteHit(g,a,s,e)
    if e then
    cancelTween('eeeedad')
    setProperty('dad.alpha', 0.8)
    doTweenAlpha('dad', 'dad', 1, 0.1, 'quadOut')
    setProperty('dad.color', 16777318)
    doTweenColor('eeeedad', 'dad', 16777215, 0.1, 'quadOut')

    end
    health = getProperty('health')
    if getProperty('health') > 0.1 then
        setProperty('health', health -0.0);
    end
end

local color = 16777318
local tweenInProgress = false
local colorTween = false

function onCreatePost()
    setProperty('songSign.visible', false)
    setProperty('songSignTxt.visible', false)
    makeLuaSprite('defaultCamZoomTween', nil, 0.7, 0)
    addLuaSprite('defaultCamZoomTween', false)
    setProperty('defaultCamZoomTween.visible', false)
    makeLuaSprite('colorTween', nil, 0.7, 0)
    addLuaSprite('colorTween', false)
    setProperty('colorTween.visible', false)
    makeLuaSprite('angleTween', nil, getProperty('camGame.angle'), 0)
    addLuaSprite('angleTween', false)
    setProperty('angleTween.visible', false)
    end
    
    
    function onBeatHit()
    if curBeat == 16 then
    setProperty('camHUD.alpha', 0)
    doTweenX('CamSqeuence', 'angleTween', -5, 8, 'quadInOut')
    end
    if curBeat == 16 or curBeat == 17 then
    triggerEvent('Add Camera Zoom', 0.005, 0.0005)
    end
    if curBeat == 18 or curBeat == 19 then
    triggerEvent('Add Camera Zoom', 0.06, 0.006)
    end
    if curBeat == 20 or curBeat == 21 then
    triggerEvent('Add Camera Zoom', 0.005, 0.0005)
    end
    if curBeat == 22 or curBeat == 23 then
    triggerEvent('Add Camera Zoom', 0.06, 0.006)
    end
    if curBeat == 24 or curBeat == 25 then
    triggerEvent('Add Camera Zoom', 0.05, 0.005)
    end
    if curBeat == 26 or curBeat == 27 then
    triggerEvent('Add Camera Zoom', 0.1, 0.05)
    end
    if curBeat == 28 or curBeat == 29 then
    triggerEvent('Add Camera Zoom', 0.05, 0.005)
    end
    if curBeat == 30 or curBeat == 31 then
    triggerEvent('Add Camera Zoom', 0.15, 0.09)
    end
    if curBeat < 32 and curBeat > 15 then
    setProperty('colorTween.x', 16777215)
    setProperty('camGame.angle', getProperty('angleTween.x'))
    doTweenX('colorTween', 'colorTween', color, 0.35, 'quadOut')
    colorTween = true
    end
    if curBeat == 32 then
    setProperty('camHUD.alpha', 1)
    doTweenAngle('CamSqeuence', 'camGame', 0, 1, 'quadInOut')
    setProperty('boyfriend.color', 16777215)
    setProperty('gf.color', 16777215)
    setProperty('dad.color', 16777215)
    end
    if curBeat == 64 then
    setProperty('defaultCamZoom', 0.62)
    doTweenColor('bf', 'boyfriend', 16777215, 1.2, 'quadOut')
    doTweenColor('gf', 'gf', 16777215, 1.2, 'quadOut')
    doTweenColor('rrdad', 'dad', 16777215, 1.2, 'quadOut')
    end
    if curBeat == 80 then
    setProperty('defaultCamZoom', 0.7)
    end
    if curBeat == 84 then
    setProperty('defaultCamZoom', 0.75)
    end
    if curBeat == 88 then
    setProperty('defaultCamZoom', 0.8)
    end
    if curBeat == 90 then
    setProperty('defaultCamZoom', 0.81)
    end
    if curBeat == 92 then
    setProperty('defaultCamZoom', 0.86)
    end
    if curBeat == 94 then
    setProperty('defaultCamZoom', 0.88)
    end
    if curBeat == 96 then
    setProperty('defaultCamZoom', 0.7)
    triggerEvent('Add Camera Zoom', 0.20, 0.1)
    doTweenX('CamZOom', 'defaultCamZoomTween', 0.9, 17, 'quadInOut')
    tweenInProgress = true
    doTweenAngle('camSS', 'camGame', -7, 18, 'quadInOut')
    end
    if curBeat == 128 then
    setProperty('defaultCamZoom', 0.8)
    doTweenAngle('camSS', 'camGame', 1, 1.5, 'quadInOut')
    end
    if curBeat == 144 then
    setProperty('defaultCamZoom', 0.75)
    end
    if curBeat == 160 then
    setProperty('defaultCamZoom', 0.7)
    end
    end
    
    function onUpdate()
    if tweenInProgress then
    setProperty('defaultCamZoom', getProperty('defaultCamZoomTween.x'))
    end
    if colorTween then
        setProperty('boyfriend.color', getProperty('colorTween.x'))
        setProperty('gf.color', getProperty('colorTween.x'))
        setProperty('dad.color', getProperty('colorTween.x'))
    end
    end
    
    function onTweenCompleted(tag)
    if tag == 'CamZOom' then
    tweenInProgress = false
    end
    if tag == 'colorTween' then
    colorTween = false
    end
    end
