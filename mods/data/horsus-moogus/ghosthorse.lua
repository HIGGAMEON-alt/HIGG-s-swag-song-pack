holdTimer = -1.0;
singDuration = 4;
specialAnim = false;

characterAnimationsList = {};

characterAnimationsList[0] = 'idle' -- idle
characterAnimationsList[1] = 'singLEFT' -- left
characterAnimationsList[2] = 'singDOWN' -- down
characterAnimationsList[3] = 'singUP' -- up
characterAnimationsList[4] = 'singRIGHT' -- right

player3 = 'horsus'
directions = {'left', 'down', 'up', 'right'}

function onCreate() -- change this part for your character image (and the animation prefixes too) (you're also gonna need to make your own offset values)
	--- Caching the character into the memory ---
	makeAnimatedLuaSprite(player3, 'characters_preload/Horsemungus', 0, 100);

	--- Setting up Character Animations ---
	addAnimationByPrefix(player3, 'idle', 'L-idle', 24, true);
	addOffset(player3, 'idle', 60, -180)

	addAnimationByPrefix(player3, 'singLEFT', 'l-alt', 24, false);
	addOffset(player3, 'singLEFT', 124, 13)

	addAnimationByPrefix(player3, 'singDOWN', 'd-alt', 24, false);
	addOffset(player3, 'singDOWN', 7, -109)

	addAnimationByPrefix(player3, 'singUP', 'u-alt', 24, false);
	addOffset(player3, 'singUP', -35, 62)

	addAnimationByPrefix(player3, 'singRIGHT', 'r-alt', 24, false);
	addOffset(player3, 'singRIGHT', -143, 16)

end

function onCreatePost()
	setProperty(player3..'.flipX', false) -- remove this for other characters, this flips their x position
	addLuaSprite(player3, true);
	setProperty(player3..'.alpha',0)
	scaleObject(player3,1.45,1.45)
	setProperty(player3..'.antialiasing',false)
	setObjectCamera(player3, 'hud');

end
local allowbop = false


function onCountdownTick(count)
	if count % 2 == 0 then
		characterPlayAnimation(0, false)
	end
end
function opponentNoteHit(id, noteData, noteType, isSustainNote)
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
	playAnim(player3, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)

	if animId > 0 then 
		specialAnim = true ;
		holdTimer = 0;
	end
end
function onUpdate(elapsed)
	holdCap = stepCrochet * 0.0011 * singDuration;
	if holdTimer >= 0 then
		holdTimer = holdTimer + elapsed;
		if holdTimer >= holdCap and getProperty(player3..".animation.curAnim.name"):sub(1,4) == 'sing' then
			characterPlayAnimation(0, false)
			holdTimer = -1;
		end
	end
	if getProperty(player3..".animation.curAnim.finished") and specialAnim then
		specialAnim = false;
	end
end


    function onStepHit()
	if curStep == 520 or curStep == 536 or curStep == 551 or curStep == 568 or curStep == 648 or curStep == 664 or curStep == 680 or curStep == 696 or curStep == 1296 then
		setProperty(player3..'.alpha',0.5)
	end
	if curStep == 528 or curStep == 543 or curStep == 560 or curStep == 576 or curStep == 656 or curStep == 672 or curStep == 688 or curStep == 704 then
		doTweenAlpha('turnback', player3, 0, 0.2, 'linear');
	end
	if curStep == 1552 then
	doTweenAlpha('endyooo', player4, 0, 4, 'linear');
	end
end