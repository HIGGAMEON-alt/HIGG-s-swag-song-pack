flipped = true
flippedIdle = false
defaultY = 0
nomoreourple = false
function onCreatePost()
	defaultY = getProperty('dad.y')
end
function onBeatHit() 
	if nomoreourple == false then
	if getProperty('healthBar.percent') < 80 then
		flipped = not flipped
		setProperty('iconP2.flipX', flipped)
	end
	
	if curBeat % 1 == 0 and getProperty('dad.animation.curAnim.name') == 'idle' then
		flippedIdle = not flippedIdle
		setProperty('dad.flipX', flippedIdle)
		setProperty('dad.y', getProperty('dad.y') + 20)
		doTweenY('raise', 'dad', getProperty('dad.y') - 20, 0.15, 'cubeOut')
	end
end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if nomoreourple == false then
	if not getPropertyFromGroup('notes', id, 'gfNote') then
	cancelTween('raise')
	setProperty('dad.y', defaultY)
	setProperty('dad.flipX', false)
	end
end
end

function onStepHit() 
	if nomoreourple == false then
	if getProperty('healthBar.percent') > 80 and curStep % 2 == 0 then
		flipped = not flipped
		setProperty('iconP2.flipX', flipped)
	end
end
end

function onUpdate(e)
	if nomoreourple == false then
	local angleOfs = math.random(-5, 5)
	if getProperty('healthBar.percent') > 80 then
		setProperty('iconP2.angle', angleOfs)
	else
		setProperty('iconP2.angle', 0)
	end
end
end

function onEvent(n, v1, v2)
if n == 'Change Character' then
if v1 == 'dad' then
setProperty('iconP2.angle', 0)
setProperty('iconP2.flipX', false)
setProperty('dad.angle', 0)
setProperty('dad.flipX', false)
nomoreourple = true
addLuaScript('characters/'..v2)
debugPrint(v2)
end
end
end