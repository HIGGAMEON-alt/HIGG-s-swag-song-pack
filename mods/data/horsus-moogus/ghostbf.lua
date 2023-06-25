holdTimer = -1.0;
singDuration = 4;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player4 = 'bfsus'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player4, 'characters_preload/horsebf', 700, 350);

	--- Setting up Character Animations ---
	addAnimationByPrefix(player4, 'idle', 'idle', 24, true);
	addOffset(player4, 'idle', -35, 110)

	addAnimationByPrefix(player4, 'singLEFT', 'left', 24, false);
	addOffset(player4, 'singLEFT', 45, 114)

	addAnimationByPrefix(player4, 'singDOWN', 'down', 24, false);
	addOffset(player4, 'singDOWN', 16, 84)

	addAnimationByPrefix(player4, 'singUP', 'up', 24, false);
	addOffset(player4, 'singUP', -14, 130)

	addAnimationByPrefix(player4, 'singRIGHT', 'right', 24, false);
	addOffset(player4, 'singRIGHT', -48, 105)

end

function onCreatePost()
	setProperty(player4..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player4, true);
	setProperty(player4..'.alpha',0)
	scaleObject(player4,1.45,1.45)
	setProperty(player4..'.antialiasing',false)
	setObjectCamera(player4, 'hud');

end
local allowbop = false


function onCountdownTick(count)
	if count % 2 == 0 then
		characterPlayAnimation(0, false)
	end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
		characterPlayAnimation(noteData + 1, true)
end
function characterPlayAnimation(animId, forced) -- thank you shadowmario :imp:
	-- 0 = idle
	-- 1 = left
	-- 2 = down
	-- 3 = up
	-- 4 = right

	specialAnim = false;

	local animName = characterAnimationsList[animId]
	playAnim(player4, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player4..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
	if getProperty(player4..".animation.curAnim.finished") and specialAnim then
		specialAnim = false;
	end
end


    function onStepHit()
	if curStep == 584 or curStep == 600 or curStep == 616 or curStep == 632 or curStep == 712 or curStep == 728 or curStep == 744 or curStep == 760 then
		setProperty(player4..'.alpha',0.5)
	end
	if curStep == 592 or curStep == 608 or curStep == 624 or curStep == 640 or curStep == 720 or curStep == 736 or curStep == 752 or curStep == 768 then
		doTweenAlpha('turnback', player4, 0, 0.2, 'linear');
	end
	if curStep == 1356 then
	doTweenAlpha('boofappear', player4, 0.5, 1.5, 'linear');
	end
	if curStep == 1552 then
	doTweenAlpha('endyooo', player4, 0, 4, 'linear');
	end
end