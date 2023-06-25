local Step = 1 --1
local out = 5 --5
--right mode
local rightmode = false;
local position_intro = 0
local position_outro = -500
--text--
local composername = 'micky\npogo'
local chartername = 'reied\nratang'
local artistname = 'ent\ngag'

function onCreate()
	makeLuaSprite('B0X', 'C_box', -500, 190);
	addLuaSprite('B0X', true)
	setObjectCamera('B0X', 'other');
	scaleObject('B0X', 0.75, 1.25);
	setProperty('B0X.alpha', 0.75);
	
	--text--
	-----Default text-----
	makeLuaText('songname', string.upper(songName), 0, -500, 205)
	setTextSize('songname', 35)
	setObjectCamera('songname', 'other');
	addLuaText('songname', true)
	setTextColor('songname', 'ffffff')
	setTextAlignment("songname", "left")
	
	makeLuaText('composer', 'Composer', 0, -500, 260)
	setTextSize('composer', 30)
	setObjectCamera('composer', 'other');
	addLuaText('composer', true)
	setTextColor('composer', 'FFC733')
	setTextAlignment("composer", "left")
	
	makeLuaText('charter', 'Charter', 0, -500, 350)
	setTextSize('charter', 30)
	setObjectCamera('charter', 'other');
	addLuaText('charter', true)
	setTextColor('charter', 'FFC733')
	setTextAlignment("charter", "left")
	
	makeLuaText('artist', 'Artist', 0, -500, 440)
	setTextSize('artist', 30)
	setObjectCamera('artist', 'other');
	addLuaText('artist', true)
	setTextColor('artist', 'FFC733')
	setTextAlignment("artist", "left")
	-----changeable text-----
	makeLuaText('composer-name', ' ', 0, -500, 290)
	setTextSize('composer-name', 28)
	setObjectCamera('composer-name', 'other');
	addLuaText('composer-name', true)
	setTextAlignment("composer-name", "left")
	
	makeLuaText('charter-name', ' ', 0, -500, 380)
	setTextSize('charter-name', 28)
	setObjectCamera('charter-name', 'other');
	addLuaText('charter-name', true)
	setTextAlignment("charter-name", "left")
	
	makeLuaText('artist-name', ' ', 0, -500, 470)
	setTextSize('artist-name', 28)
	setObjectCamera('artist-name', 'other');
	addLuaText('artist-name', true)
	setTextAlignment("artist-name", "left")

end

function onCreatePost()
-- 특정 곡에 크레딧을 적용하고 싶으면 아래의 if songName == 'encounter' then을 복사해서 end 아래에 붙여넣기 하신 뒤 원하시는걸 적으시면 됩니다
-- 글에 엔터 기능을(뭐라고 부르는지 몰?루) 넣고 싶으시면 떼어내고 싶은 텍스트 사이에 \n을 넣으세요

-- ↓↓"안녕\n하세요"↓↓
-- "안녕
-- 하세요"
-------------------------------------------------
	if songName == 'encounter' then --곡 인식 (data 폴더 이름으로 적어야함!!!!)
	rightmode = false; --크레딧이 오른쪽에서 올라올지 설정
	Step = 1; --크레딧이 몇번쨰 Step에 올라오는지 결정
	Out = 5; --크레딧이 몇초 뒤 사라질지 결정
	setTextColor('songname', '33B8FF') --곡 이름 색상
	composername = 'composer name here' --작곡가 이름
	chartername = 'charter name here' --차터 이름
	artistname = 'artist name here' --아티스트 이름
	end
	if songName == 'catastrophe' then --카타스트로피
	rightmode = false; 
	Step = 1;
	Out = 5;
	setTextColor('songname', '802283')
	composername = 'I'
	chartername = 'D' 
	artistname = 'K'
	end
-------------------------------------------------
--결정된 이름 적용 건들지마셈!!!
--결정된 이름 적용 건들지마셈!!!
   setTextString('composer-name', composername)
   setTextString('charter-name', chartername)
   setTextString('artist-name', artistname)
--결정된 이름 적용 건들지마셈!!!
--결정된 이름 적용 건들지마셈!!!
end

function onStepHit()
	if curStep == Step then
	    if rightmode == true then
		position_intro = 930
		position_outro = 1500
		setProperty('B0X.x', position_outro);
		setProperty('songname.x', position_outro);
		setProperty('composer.x', position_outro);
		setProperty('charter.x', position_outro);
		setProperty('artist.x', position_outro);
		setProperty('composer-name.x', position_outro);
		setProperty('charter-name.x', position_outro);
		setProperty('artist-name.x', position_outro);
	    end
	doTweenX('NameTweenX', 'B0X', position_intro, 2, 'CircInOut');
	runTimer('nameout', out);
	
	doTweenX('songname_Intro', 'songname', position_intro, 2, 'CircInOut');
	doTweenX('composer_Intro', 'composer', position_intro, 2, 'CircInOut');
	doTweenX('charter_Intro', 'charter', position_intro, 2, 'CircInOut');
	doTweenX('artist_Intro', 'artist', position_intro, 2, 'CircInOut');
	doTweenX('composername_Intro', 'composer-name', position_intro, 2, 'CircInOut');
	doTweenX('chartername_Intro', 'charter-name', position_intro, 2, 'CircInOut');
	doTweenX('artistname_Intro', 'artist-name', position_intro, 2, 'CircInOut');
	end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'B0X', position_outro, 2, 'CircInOut');
	
	doTweenX('songname_outro', 'songname', position_outro, 2, 'CircInOut');
	doTweenX('composer_outro', 'composer', position_outro, 2, 'CircInOut');
	doTweenX('charter_outro', 'charter', position_outro, 2, 'CircInOut');
	doTweenX('artist_outro', 'artist', position_outro, 2, 'CircInOut');
	doTweenX('composername_outro', 'composer-name', position_outro, 2, 'CircInOut');
	doTweenX('chartername_outro', 'charter-name', position_outro, 2, 'CircInOut');
	doTweenX('artistname_outro', 'artist-name', position_outro, 2, 'CircInOut');
    end
end