local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('2');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onSongStart()

   --black screen at the beginning

   	    makeLuaSprite('black','',-200,-30)
	    makeGraphic('black',2000,2000,'000000')
	    addLuaSprite('black',false)
        setScrollFactor('black',0,0)
        setObjectCamera('black','hud')
		
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
	


end