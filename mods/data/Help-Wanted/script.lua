local twistShit = 1

function onCreatePost()
setProperty('camGame.zoom', 0.768)
end

function onStepHit()
if curStep == 32 then
setProperty('defaultCamZoom', 0.9)
end
if curStep == 50 then
setProperty('defaultCamZoom', 0.8)
end
if curStep == 1536 then
setProperty('camGame.zoom', 0.768)
setProperty('defaultCamZoom', 0.9)
end
if curStep == 1554 then
setProperty('defaultCamZoom', 0.8)
end
end

function onBeatHit()
if curBeat >= 320 and curBeat <= 383 then
    if curBeat % 1 == 0 then
        doTweenY('camHUDy', 'camHUD', -6 * 0.6, stepCrochet * 0.002, 'circInOut');
    end
    if curBeat % 1 == 2 then
        doTweenY('camHUDy', 'camHUD', 0, stepCrochet * 0.002, 'circInOut');
    end
        if curBeat % 2 == 0 then
            twistShit = 1;
            doTweenAngle('camGameleft', 'camGame', twistShit * 0.3, stepCrochet * 0.002, 'circInOut');
            doTweenAngle('camHUDleft', 'camHUD', twistShit * 0.3, stepCrochet * 0.002, 'circInOut');
            setProperty('camGame.x', -5)
            doTweenX('camGameleft', 'camGame', 0, stepCrochet * 0.002, 'circInOut')
        else
            twistShit = 1;
            doTweenAngle('camHUDright', 'camHUD', -twistShit * 0.3, stepCrochet * 0.001, 'linear');
            doTweenAngle('camGameright', 'camGame', -twistShit * 0.3, stepCrochet * 0.001, 'linear');
            setProperty('camGame.x', 5)
            doTweenX('camGameright', 'camGame', 0, stepCrochet * 0.002, 'circInOut')
        end
        setProperty('camGame.angle', twistShit * 0.6);
        setProperty('camHUD.angle', twistShit * 0.6);
    end
end
