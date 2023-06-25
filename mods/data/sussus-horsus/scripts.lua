local angleshit = 0.3;
local anglevar = 0.3;
local highlight = false;

function onCreate()
    makeLuaSprite('Horse1', 'horse/horse1', 0, 0);
    setProperty("Horse1.alpha",0)
    setObjectCamera('Horse1', 'camHUD');
	makeLuaSprite('Horse2', 'horse/wtiis', 0, 0);
    setProperty("Horse2.alpha",0)
    setObjectCamera('Horse2', 'camHUD');
	
	addLuaSprite('Horse1', false);
	addLuaSprite('Horse2', false);
end

function onBeatHit()
	if curBeat > 64 and curBeat < 128 or curBeat > 256 and curBeat < 319 or curBeat > 324 and curBeat < 388 then
		triggerEvent('Add Camera Zoom', 0.04,0.05)

	    	if curBeat % 2 == 0 then
			angleshit = anglevar;
	    	else
			angleshit = -anglevar;
	    	end
	    	setProperty('camHUD.angle',angleshit*3)
	    	setProperty('camGame.angle',angleshit*3)
	    	doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
	    	doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
	    	doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
	    else
	    	setProperty('camHUD.angle',0)
	    	setProperty('camHUD.x',0)
	    	setProperty('camHUD.x',0)
	    end
	end

function onStepHit()
    if curStep == 120 then
	setProperty("Horse1.alpha",1)
	end
	if curStep == 128 then
	setProperty("Horse1.alpha",0)
	end
	if curStep == 240 then
	setProperty("Horse2.alpha",1)
	end
	if curStep == 256 then
	setProperty("Horse2.alpha",0)
	end
    if curStep == 9999 or curStep == 9999 or curStep == 9999 then
	triggerEvent('Camera Follow Pos', 1250, 600)
	end
    if curStep == 9999 then
	doTweenAlpha('catahudfade', 'camHUD', 0, 3, 'linear');
	end
	if curStep == 9999 then
	doTweenAlpha('catahudfadeback', 'camHUD', 1, 2, 'linear');
	end
	if curStep == 9999 or curStep == 9999 then
	triggerEvent('Camera Follow Pos', 1580, 860)
	end
	
	
	if curBeat > 256 and curBeat > 504 then
    		if curStep % 4 == 0 then
    			doTweenY('rrr', 'camHUD', -12, stepCrochet*0.002, 'circOut')
	    		doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn')
	    	end
	    	if curStep % 4 == 2 then
    			doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn')
    			doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn')
        	end
    	end
	end