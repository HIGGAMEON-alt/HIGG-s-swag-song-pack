local skyBGPos = 0
local skyBGPos2 = 0
local skyBGPos3 = 0

function onCreate()
	addLuaScript("scripts/extra/fonts/Default Font")

    -- Outside
    makeLuaSprite("sky", "backgrounds/overfilled/sky", -160 * 3, -81 * 3 + 3)
	setProperty("sky.antialiasing", false)
	scaleObject("sky", 6, 6)
	addLuaSprite("sky", false)

    if not lowQuality then
        makeLuaSprite("mountains", "backgrounds/overfilled/mountains", -160 * 3, -81 * 3 + 3)
        setProperty("mountains.antialiasing", false)
        setProperty("mountains.alpha", 0.5)
        scaleObject("mountains", 6, 6)
        addLuaSprite("mountains", false)
        makeLuaSprite("mountains2", "backgrounds/overfilled/mountains", getProperty("mountains.width"), -81 * 3 + 3)
        setProperty("mountains2.antialiasing", false)
        setProperty("mountains2.alpha", 0.5)
        scaleObject("mountains2", 6, 6)
        addLuaSprite("mountains2", false)
        makeLuaSprite("mountains3", "backgrounds/overfilled/mountains", -getProperty("mountains.width"), -81 * 3 + 3)
        setProperty("mountains3.antialiasing", false)
        setProperty("mountains3.alpha", 0.5)
        scaleObject("mountains3", 6, 6)
        addLuaSprite("mountains3", false)
    end

    makeLuaSprite("background", "backgrounds/overfilled/background", -160 * 3, -81 * 3 + 3)
	setProperty("background.antialiasing", false)
	scaleObject("background", 6, 6)
	addLuaSprite("background", false)
    makeLuaSprite("background2", "backgrounds/overfilled/background", getProperty("background.width"), -81 * 3 + 3)
    setProperty("background2.antialiasing", false)
    scaleObject("background2", 6, 6)
    addLuaSprite("background2", false)
    makeLuaSprite("background3", "backgrounds/overfilled/background", -getProperty("background.width"), -81 * 3 + 3)
    setProperty("background3.antialiasing", false)
    scaleObject("background3", 6, 6)
    addLuaSprite("background3", false)

    makeAnimatedLuaSprite("ground", "backgrounds/overfilled/ground", -160 * 3, -81 * 3 + 3)
    addAnimationByPrefix("ground", "idle", "idle0", 9)
	setProperty("ground.antialiasing", false)
	scaleObject("ground", 6, 6)
	addLuaSprite("ground", false)
    makeLuaSprite("ground2", "backgrounds/overfilled/ground", getProperty("ground.width"), -81 * 3 + 3)
    setProperty("ground2.antialiasing", false)
    scaleObject("ground2", 6, 6)
    addLuaSprite("ground2", false)
    makeLuaSprite("ground3", "backgrounds/overfilled/ground", -getProperty("ground.width"), -81 * 3 + 3)
    setProperty("ground3.antialiasing", false)
    scaleObject("ground3", 6, 6)
    addLuaSprite("ground3", false)

    -- Inside
    makeLuaSprite("backgroundApt", "backgrounds/overfilled/backgroundApt", -160 * 3, -81 * 3 + 3)
	setProperty("backgroundApt.antialiasing", false)
	scaleObject("backgroundApt", 6, 6)
	addLuaSprite("backgroundApt", false)
    makeLuaSprite("backgroundApt2", "backgrounds/overfilled/backgroundApt", getProperty("backgroundApt.width"), -81 * 3 + 3)
    setProperty("backgroundApt2.antialiasing", false)
    scaleObject("backgroundApt2", 6, 6)
    addLuaSprite("backgroundApt2", false)
    makeLuaSprite("backgroundApt3", "backgrounds/overfilled/backgroundApt", -getProperty("backgroundApt.width"), -81 * 3 + 3)
    setProperty("backgroundApt3.antialiasing", false)
    scaleObject("backgroundApt3", 6, 6)
    addLuaSprite("backgroundApt3", false)

    makeLuaSprite("groundApt", "backgrounds/overfilled/groundApt", -160 * 3, -81 * 3 + 3)
	setProperty("groundApt.antialiasing", false)
	scaleObject("groundApt", 6, 6)
	addLuaSprite("groundApt", false)
    makeLuaSprite("groundApt2", "backgrounds/overfilled/groundApt", getProperty("groundApt.width"), -81 * 3 + 3)
    setProperty("groundApt2.antialiasing", false)
    scaleObject("groundApt2", 6, 6)
    addLuaSprite("groundApt2", false)
    makeLuaSprite("groundApt3", "backgrounds/overfilled/groundApt", -getProperty("groundApt.width"), -81 * 3 + 3)
    setProperty("groundApt3.antialiasing", false)
    scaleObject("groundApt3", 6, 6)
    addLuaSprite("groundApt3", false)

    makeLuaSprite("transition", "backgrounds/overfilled/transitionApt", -160 * 3, -81 * 3 + 3)
	setProperty("transition.antialiasing", false)
    setProperty("transition.visible", false)
	scaleObject("transition", 6, 6)
	addLuaSprite("transition", true)
    transitionPos = -160 * 3 + getProperty("transition.width")
end

function onUpdate(elapsed)
    if getTextString("isPaused") ~= "true" then
        if flashingLights then
            moveMult = 1
        else
            moveMult = 0.5
        end	

        skyBGPos = skyBGPos - 900 * elapsed * moveMult
        if skyBGPos + getProperty("ground.width") <= 0 then
            skyBGPos = 0
        end
        setProperty("ground.x", math.floor(skyBGPos / 6) * 6)
        setProperty("ground2.x", getProperty("ground.x") + getProperty("ground.width"))
        setProperty("ground3.x", getProperty("ground.x") - getProperty("ground.width"))
        setProperty("groundApt.x", getProperty("ground.x"))
        setProperty("groundApt2.x", getProperty("ground.x") + getProperty("ground.width"))
        setProperty("groundApt3.x", getProperty("ground.x") - getProperty("ground.width"))
        if lowQuality then
            setProperty("background.x", math.floor(skyBGPos / 6) * 6)
            setProperty("background2.x", getProperty("background.x") + getProperty("background.width"))
            setProperty("background3.x", getProperty("background.x") - getProperty("background.width"))
        else
            skyBGPos2 = skyBGPos2 - 600 * elapsed * moveMult
            if skyBGPos2 + getProperty("background.width") <= 0 then
                skyBGPos2 = 0
            end
            setProperty("background.x", math.floor(skyBGPos2 / 6) * 6)
            setProperty("background2.x", getProperty("background.x") + getProperty("background.width"))
            setProperty("background3.x", getProperty("background.x") - getProperty("background.width"))
        end
        setProperty("backgroundApt.x", getProperty("background.x"))
        setProperty("backgroundApt2.x", getProperty("background.x") + getProperty("background.width"))
        setProperty("backgroundApt3.x", getProperty("background.x") - getProperty("background.width"))

        if not lowQuality then
            skyBGPos3 = skyBGPos3 - 300 * elapsed * moveMult
            if skyBGPos3 + getProperty("mountains.width") <= 0 then
                skyBGPos3 = 0
            end
            setProperty("mountains.x", math.floor(skyBGPos3 / 6) * 6)
            setProperty("mountains2.x", getProperty("mountains.x") + getProperty("mountains.width"))
            setProperty("mountains3.x", getProperty("mountains.x") - getProperty("mountains.width"))
        end

        if getProperty("transition.visible") then
            transitionPos = transitionPos - 1500 * elapsed * moveMult
            if transitionPos + getProperty("transition.width") <= -160 * 3 - getProperty("transition.width") then
                transitionPos = -160 * 3 + getProperty("transition.width")
                setProperty("transition.visible", false)
            end
            setProperty("transition.x", math.floor(transitionPos / 6) * 6)
        end

        if isRunning("scripts/extra/menus/Pause") then
            setProperty("ground.animation.curAnim.paused", false)
        end
    else
        if isRunning("scripts/extra/menus/Pause") then
            setProperty("ground.animation.curAnim.paused", true)
        end
    end
end