function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
			setPropertyFromGroup('unspawnNotes', i, 'texture', "BULLETNOTE_assets")
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', "BULLETnoteSplashes")
		end
	end
end


function dadShoot()
	playAnim("boyfriend","shoot", true);
	setProperty("boyfriend.specialAnim",true)
	setProperty(boyfriend.animTimer,1/24*14)
end

function bfPlayAnim(name)
	playAnim("boyfriend",name, true);
	setProperty("boyfriend.specialAnim",true)
	setProperty(boyfriend.animTimer,1/24*14)
end

--[[function onCreate(){
	game.judgeManager.judgmentData.set("bulletHit", {
		internalName: "miss", // name used for the image, counters internally, etc. Leave this as 'miss' so when you miss it'll show the fail image, add to the miss counter, etc.
		displayName: "Fail", // display name, not used atm but will prob be used in judge counter
		window: -1, // -1 just so even if its added to the hittable judgment array, it'll never be hit
		score: -350, // score to take away
		accuracy: -100, // % accuracy to take away on non-Wife3
		health: -50, // % of health to remove
		wifePoints: Wife3.missWeight, // makes it so that it'll take away the appropriate amount from accuracy on Wife3
		comboBehaviour: -1, // combo break
		noteSplash: false,
	});
}]]

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == "Bullet" then
	else
	return
	end
	if field == playerField then
		bfHit(note, field);
	else
		shadowHit();
	end
end

--[[function preNoteMiss(note:Note, field:PlayField){
	if (note.noteType != "Bullet")
		return;

	note.hitResult.judgment = 'bulletHit'; // makes it so instead of it being the miss judgment, it'll do our own custom judgment
	// the alternative would be setting it to 'customMiss' and then doing the damage in noteMiss
	// (customMiss is Miss but without the health)
}]]

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == "Bullet" then
	else
	return
	end

	if field == playerField then
		dadShoot();
		bfPlayAnim("shot");
		
		game.camHUD.shake(0.01, 0.2);
		game.camGame.shake(0.01, 0.2);
		game.camGame.flash(0xCCFF0000, 0.2, null, true); -- red
		
		game.callOnHScripts("onShoot", {note, field});
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == "Bullet" then
	else
	return
	end

	if field == playerField then
		bfHit(direction, field);
	else
		shadowHit();
	end
end

function bfHit(note, field)

	dadShoot();	
	bfPlayAnim("dodge");
	
	game.camGame.shake(0.01, 0.2);
	
	game.callOnHScripts("onShoot", {note, field});
end

function shadowHit()
	if game.playerField.isPlayer then
		setProperty("health", getProperty('health') * .25) -- fuck it
	
	dadShoot();
end
end