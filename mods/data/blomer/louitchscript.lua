--[[
    Code made by Drawoon_
    Character creator
]]
function onCreate()
    sing={'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
    NewsCharacter={{Type='BF',Name='boyfriend'},{Type='DAD',Name='dad'}}--Don't Delete
    NewsCharacter={{Type='BF',Name='boyfriend'},{Type='DAD',Name='dad'}}--Don't Delete
    DadSinger={}
    BfSinger={}
    --[[
    Types="BF"/'DAD'

    CreateCharacter(CharName,Types,PosX,PosY,Tag) Add Character

    RemoveCharacter(Tag) Delete Character

    ChangeSingChar(Tag/'All',Types) Change Charater Singer

    CharacterExist(tag):Bool if Character exist=true

    FindArrayPos(Tag):Int Find Charater Array Pos

    ]]

end
function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        setPropertyFromGroup('unspawnNotes', i, 'noAnimation',true)  
        setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation',true)  
    end
	-------------------------------------------------------i want to fucking die
    
    ChangeSingChar('boyfriend','BF')
    ChangeSingChar('dad','DAD')
	
	CreateCharacter('loitchsback','BF',-200,-70,'louitch')
	setProperty('louitch.alpha', 0)
	setObjectOrder('boyfriendGroup', getObjectOrder('louitch') + 1)
	
end
function onBeatHit()
    for i=1,#NewsCharacter do
        BeatTag= NewsCharacter[i]["Name"]
    if curBeat% getProperty(BeatTag..'.danceEveryNumBeats')==0 and getProperty(BeatTag..'.animation.curAnim')~=nil and not stringStartsWith(getProperty(BeatTag..'.animation.curAnim.name'),'sing') and not getProperty(BeatTag..'.stunned') then
    runHaxeCode([[
            getVar(']]..BeatTag..[[').dance(); 
    ]])
    end
    end
	
end

function onStepHit()
    if curStep == 1344 then
	    setProperty('louitch.alpha', 255)
    end
    if curStep == 1405 then
	    ChangeSingChar('louitch','BF')
    end
	if curStep == 2047 then
	   ChangeSingChar('boyfriend','BF')
	end
	if curStep == 2175 then
	   ChangeSingChar('louitch','BF')
	end
	if curStep == 2495 then
	   ChangeSingChar('boyfriend','BF')
	end
end
function onUpdate(elapsed)
    for i=1,#NewsCharacter do
        UpdateTag= NewsCharacter[i]["Name"]
    if getProperty(UpdateTag..'.holdTimer') > stepCrochet * (0.0011 / playbackRate) * getProperty(UpdateTag..'.singDuration') and  stringStartsWith(getProperty(UpdateTag..'.animation.curAnim.name'),'sing') and not stringEndsWith(getProperty(UpdateTag..'.animation.curAnim.name'),'miss') then
        runHaxeCode([[
            getVar(']]..UpdateTag..[[').dance(); 
        ]])
    end
    end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if DadSinger[1]=='All' then
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Type"]=='DAD' then
            runHaxeCode([[
                getVar(']]..NewsCharacter[i]["Name"]..[[').playAnim(']]..sing[noteData+1]..[[',true);
                getVar(']]..NewsCharacter[i]["Name"]..[[').holdTimer=0;
            ]])
            if NewsCharacter[i]["Name"]=='dad' then
                runHaxeCode([[
                    game.dad.playAnim(']]..sing[noteData+1]..[[',true);
                    game.dad.holdTimer=0;
                ]])
            end
        end
    end
    else
        for i=1,#DadSinger do
                runHaxeCode([[
                    getVar(']]..DadSinger[i]..[[').playAnim(']]..sing[noteData+1]..[[',true);
                    getVar(']]..DadSinger[i]..[[').holdTimer=0;
                ]])
            if DadSinger[i]=='dad' then
                runHaxeCode([[
                    game.dad.playAnim(']]..sing[noteData+1]..[[',true);
                    game.dad.holdTimer=0;
                ]])
            end
        end
    end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if BfSinger[1]=='All' then
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Type"]=='BF' then
            runHaxeCode([[
                getVar(']]..NewsCharacter[i]["Name"]..[[').playAnim(']]..sing[noteData+1]..[[',true);
                getVar(']]..NewsCharacter[i]["Name"]..[[').holdTimer=0;
            ]])
        end
        if NewsCharacter[i]["Name"]=='boyfriend' then
            runHaxeCode([[
                game.boyfriend.playAnim(']]..sing[noteData+1]..[[',true);
                game.boyfriend.holdTimer=0;
            ]])
        end
    end
    else
        for i=1,#BfSinger do
        runHaxeCode([[
            getVar(']]..BfSinger[i]..[[').playAnim(']]..sing[noteData+1]..[[',true);
            getVar(']]..BfSinger[i]..[[').holdTimer=0;
        ]])
        if BfSinger[i]=='boyfriend' then
            runHaxeCode([[
                game.boyfriend.playAnim(']]..sing[noteData+1]..[[',true);
                game.boyfriend.holdTimer=0;
            ]])
        end
        end
    end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if BfSinger[1]=='All' then
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Type"]=='BF' then
            runHaxeCode([[
            getVar(']]..NewsCharacter[i]["Name"]..[[').playAnim(']]..sing[noteData+1]..[['+'miss',true);
            ]])
        end
        if NewsCharacter[i]["Name"]=='boyfriend' then
            runHaxeCode([[
                game.boyfriend.playAnim(']]..sing[noteData+1]..[['+'miss',true);
            ]])
        end
    end
else
    for i=1,#BfSinger do
        runHaxeCode([[
            getVar(']]..BfSinger[i]..[[').playAnim(']]..sing[noteData+1]..[['+'miss',true);
        ]])
        if BfSinger[i]=='boyfriend' then
            runHaxeCode([[
                game.boyfriend.playAnim(']]..sing[noteData+1]..[['+'miss',true);
            ]])
        end
    end
end
end
function onEvent(eventName, value1, value2)
    if eventName=='Play Animation' then
        if CharacterExist(value2) then
        runHaxeCode([[
            getVar(']]..value2..[[').playAnim(']]..value1..[[',true);
            getVar(']]..value2..[[').specialAnim=true;
        ]])
        end
    end
    if eventName=='ChangeSingCharacter' then
        ChangeSingChar(value1,value2)
    end
end
function CreateCharacter(CharName,tYpe,PosX,PosY,Tag)
    if CharacterExist(Tag) then
        RemoveCharacter(Tag)
    end
    if tYpe =='DAD' then
        runHaxeCode([[
            var Dad2:Character;
            Dad2 = new Character(]]..PosX+getCharacterX('dad')..[[,]]..PosY+getCharacterY('dad')..[[,']]..CharName..[[');
            game.add(Dad2);
            Dad2.dance();
            Dad2.x +=Dad2.positionArray[0];
            Dad2.y +=Dad2.positionArray[1];
            setVar(']]..Tag..[[',Dad2);
        ]])
    else 
        runHaxeCode([[
            var BF2:Boyfriend;
            BF2 = new Boyfriend(]]..PosX+getCharacterX('bf')..[[,]]..PosY+getCharacterY('bf')..[[,']]..CharName..[[');
            game.add(BF2);
            BF2.dance();
            BF2.x +=BF2.positionArray[0];
            BF2.y +=BF2.positionArray[1];
            setVar(']]..Tag..[[',BF2);
        ]])
    end
    --ChangeSingChar(Tag,tYpe)
    table.insert(NewsCharacter,{Type=tYpe,Name=Tag})


end
function RemoveCharacter(Tag)
    runHaxeCode([[
        getVar(']]..Tag..[[').kill();
        removeVar(']]..Tag..[[');
    ]])
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Name"]==Tag then
            table.remove(NewsCharacter, i)
        end
    end
end
function FindArrayPos(Tag)
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Name"]==Tag then
            return i
        end
    end
end
function CharacterExist(tag)
    for i=1,#NewsCharacter do
        if NewsCharacter[i]["Name"]==tag then
            return true 
        end
        if i==#NewsCharacter then
            return false
        end
    end
end
function ChangeSingChar(Tag,Types)
    Tag=stringSplit(Tag,',')
    if Types=='DAD' then
        DadSinger=Tag
    elseif Types=='BF' then 
        BfSinger=Tag
    end
end
function eventEarlyTrigger(name)
    if name == 'ChangeSingCharacter' then
        return stepCrochet 
    end
end
--[[
triggerEvent('Change Character', 'loitchsback', 'loitchsback')
]]