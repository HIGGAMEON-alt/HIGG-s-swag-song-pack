
local dumbass = {
    'timeBar',
    'timeBarBG',
    'healthBar',
    'healthBarBG',
    'iconP1',
    'iconP2',
    'timeTxt',
    'scoreTxt',
	'defaultPlayerStrumX0',
    'defaultPlayerStrumX1',
    'defaultPlayerStrumX2',
    'defaultPlayerStrumX3',
    'defaultOpponentStrumX0',
    'defaultOpponentStrumX1',
    'defaultOpponentStrumX2',
    'defaultOpponentStrumX3',
}

function onCreate()
        setProperty('timeBar.visible', false)
        setProperty('timeTxt.visible', false)
        setProperty('timeBarBG.visible', false)
   	    makeLuaSprite('MARLO E X E','exes are fucking stupid', -1730, 395)
	    addLuaSprite('MARLO E X E',false)
		makeAnimatedLuaSprite('luitchdie','WORLD BLAST', 160, -10)
		
		scaleObject("luitchdie", 13 ,13)
		addLuaSprite('luitchdie',false)
		setProperty('luitchdie.antialiasing', false)
	    setProperty('luitchdie.alpha', 0)
		setObjectCamera('luitchdie','hud')
		
end

function onBeatHit()
    if curBeat == 36 then
   	    doTweenX('SONIC EXE NOOOOOOOOO', 'MARLO E X E', -550, 4.3, 'sinein');
	end
end

function onStepHit()
    if curStep == 193 then
	    addAnimationByPrefix('luitchdie', 'WORLD BLAST', 'world_blast_gif', 35, true);
	    setProperty('luitchdie.alpha', 1)
   	    objectPlayAnimation('luitchdie','world_blast_gif', true);
		setProperty('hud.alpha', 0)
		setProperty('grnd2.alpha', 0)
		setProperty('boo.alpha', 0)
		setProperty('bg2.alpha', 0)
		setProperty('boyfriend.alpha', 0)
		setProperty('gf.alpha', 0)
		setProperty('dad.alpha', 0)
		setProperty('MARLO E X E.alpha', 0)

        setProperty('botplayTxt.visible', false)

        setProperty('scoreTxt.visible', false)

        setProperty('healthBar.visible', false)

        setProperty('healthBarBG.visible', false)

        setProperty('iconP1.visible', false)

        setProperty('iconP2.visible', false)

        setProperty('timeTxt.visible', false)

        setPropertyFromGroup('opponentStrums', 0, 'alpha', 0)

        setPropertyFromGroup('opponentStrums', 1, 'alpha', 0)

        setPropertyFromGroup('opponentStrums', 2, 'alpha', 0)

        setPropertyFromGroup('opponentStrums', 3, 'alpha', 0)

        setPropertyFromGroup('playerStrums', 0, 'alpha', 0)

        setPropertyFromGroup('playerStrums', 1, 'alpha', 0)

        setPropertyFromGroup('playerStrums', 2, 'alpha', 0)

        setPropertyFromGroup('playerStrums', 3, 'alpha', 0)
        
		
	end
	if curStep == 219 then
	    setProperty('health', -500);
	end
end

