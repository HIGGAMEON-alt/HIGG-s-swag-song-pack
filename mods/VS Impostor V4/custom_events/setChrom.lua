local shaderList = {"temporaryShader"}

function onCreatePost()
    if shadersEnabled then
    makeLuaSprite('shaderTween', nil, 0, 0)
    addLuaSprite('shaderTween')
    setProperty('shaderTween.visible', false)
    addHaxeLibrary("ShaderFilter", "openfl.filters")
    initLuaShader('ChromaticAbberation')
    makeLuaSprite("temporaryShader")
    makeGraphic("temporaryShader", screenWidth, screenHeight)
    setSpriteShader("temporaryShader", shadname)
        for i=1,#shaderList do
        setSpriteShader(shaderList[i], 'ChromaticAbberation')
        end
        runHaxeCode([[
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        ]])
    end
end

function onEvent(n,v1,v2)
    if n == 'setChrom' then
        if shadersEnabled then
        doTweenX('shaderMoveSlave!!!', 'shaderTween', v1, v2, 'sineOut')
        end
    end
end

function onUpdate()
    for i=1,#shaderList do
    setShaderFloat(shaderList[i], 'time', os.clock())
    setShaderFloat(shaderList[i], 'intensity',  0.1 + getProperty('shaderTween.x') * 5.5 * getProperty('vocals.pitch'))
    setShaderFloat(shaderList[i], 'initial',  1 +getProperty('shaderTween.x') * 5.5 * getProperty('vocals.pitch'))
    end
end