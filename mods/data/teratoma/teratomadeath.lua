local Dead = false;
local Stop = false;
local shake = 1;

function onCreate()
  makeLuaSprite('teratomadeath_Blackscreen','HE IS BLACK', 0, 0);
  addLuaSprite('teratomadeath_Blackscreen')
  setObjectCamera('teratomadeath_Blackscreen', 'Other')
  
  makeLuaSprite('teratomadeath_jumpscare','teratomajumpscare', 0, 0);
  addLuaSprite('teratomadeath_jumpscare', true)
  setObjectCamera('teratomadeath_jumpscare', 'Other')
  
  setProperty('teratomadeath_Blackscreen.alpha',0)
  setProperty('teratomadeath_jumpscare.alpha',0)
end

function onUpdate(elapsed)
health = getProperty('health')
   if health < 0.1 then
        if Dead == false then
		URdeadbitch();
		end
   end
   if Stop == true then
		setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - elapsed * 1000  )
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
   end
   if shake == 1 then
   setProperty('teratomadeath_jumpscare.x',-5)
   setProperty('teratomadeath_jumpscare.y',-5)
   shake = shake+1
   elseif shake == 2 then
   setProperty('teratomadeath_jumpscare.x',0)
   setProperty('teratomadeath_jumpscare.y',0)
   shake = shake+1
   elseif shake == 3 then
   setProperty('teratomadeath_jumpscare.x', 5)
   setProperty('teratomadeath_jumpscare.y',-5)
   shake = 1
   end

end

function URdeadbitch()
   Dead = true;
   Stop = true;
   setProperty('vocals.volume', 0)
   setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
   setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
   health = getProperty('health');
   setProperty('health', 2);
   ---------------------------------------------------------
   setProperty('camHUD.alpha',0)
   setProperty('teratomadeath_Blackscreen.alpha',1)
   
   runTimer('jumpscare', 1.5);
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'jumpscare' then
	playSound('terajumpscare', 1)
	triggerEvent('Screen Shake','3, 0.1','3, 0.1');
	
	setProperty('teratomadeath_Blackscreen.alpha',0)
	setProperty('camHUD.alpha',1)
    setProperty('teratomadeath_jumpscare.alpha',1)
	
	runTimer('gameover', 2.25);
    end
	if tag == 'gameover' then
	health = getProperty('health');
    setProperty('health', -1);
	end
end