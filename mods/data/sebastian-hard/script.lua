local allowCountdown = false
function onStartCountdown()
        setProperty('timeBar.visible', false)
        setProperty('timeBarBG.visible', false)
		setProperty('timeTxt.visible', false)
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('2');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onSongStart()

   --black screen at the beginning
        makeAnimatedLuaSprite('sadbf', 'zad', 305, 420);
        addAnimationByPrefix('sadbf', 'zad', 'SAD', 24, true);
        objectPlayAnimation('sadbf','SAD',true)
		setProperty('sadbf.alpha', 0)
        makeLuaSprite('thepenis','iGrave', -350, 400)
		addLuaSprite('thepenis',false)
		setObjectOrder('thepenis', getObjectOrder('boyfriendGroup') + 1)
		setObjectOrder('sadbf', getObjectOrder('boyfriendGroup') + 1)
		setProperty('thepenis.alpha', 0)
		scaleObject('thepenis', 0.5, 0.5)
   	    makeLuaSprite('black','',-200,-30)
	    makeGraphic('black',2000,2000,'000000')
	    addLuaSprite('black',false)
        setScrollFactor('black',0,0)
        setObjectCamera('black','hud')
		addLuaSprite('sadbf',false)
		
	--sega text

   	    makeLuaSprite('sega','sega',250,115)
	    addLuaSprite('sega',false)
        setScrollFactor('sega',0,0)
        setObjectCamera('sega','hud')

end



function onStepHit()
	--genesis text
	if curStep == 4 then
	
   	    makeLuaSprite('genesis','genesis smile',250,260)
	    addLuaSprite('genesis',false)
        setScrollFactor('genesis',0,0)
        setObjectCamera('genesis','hud')
		
	end

   --shit disappear
	
	if curStep == 16 then
	
        removeLuaSprite('black', true);
		removeLuaSprite('sega', true);
		removeLuaSprite('genesis', true);
		
	end
	

	if curStep == 50 then
	
    doTweenAlpha('stevejobfadeout', 'dad', 0, 7, 'sineOut');
	doTweenAlpha('stevejobfadein', 'thepenis', 1, 7, 'sineOut');
	setProperty('sadbf.alpha', 1)
	setProperty('boyfriend.alpha', 0)
	end
end