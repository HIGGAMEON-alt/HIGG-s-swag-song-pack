

function onCreatePost()
    local json = dofile('HIGGAMEON-alt%HIGG-s-swag-song-pack/mods/TGT/scripts/JSONLIB.lua')
    local stageData_placeHolder = json.parse(getTextFromFile('stages/'..curStage..'.json'))
    local stageData = stageData_placeHolder
    makeLuaSprite('bg','', -1500, -1500)
    makeGraphic('bg', 5000, 5000, stageData.bg_color)
    addLuaSprite('bg', true)
    setScrollFactor('bg',0,0)
    setObjectOrder('bg', 0)
    for i = 1,stageData.preload do
    precacheImage(stageData.preload[i].path)
    end
    end