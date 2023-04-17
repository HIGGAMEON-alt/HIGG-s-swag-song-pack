Player_Camera_Move_Amount = 10 -- default is 15

Opponent_Camera_Move_Amount = 10 -- default is 10

SongStart = false
SetCamCords = false
char = gf
BFright = 0
BFleft = 0
BFup = 0
BFdown = 0
DADright = 0
DADleft = 0
DADup = 0
DADdown = 0
NOTE = ''
x = 0
y = 0
NoteCount = 0
canuarchive = true
wait = 0
UNWANTED = 'FAKENOTE'
CPUdowntime = 0
CPUuptime = 0
CPUrighttime = 0
CPUlefttime = 0
function onCreate()

makeLuaSprite("boyfriendJsonCam", null, 0, 0)
makeLuaSprite("dadJsonCam", null, 0, 0)
makeLuaSprite("gfJsonCam", null, 0, 0)
addLuaSprite("boyfriendJsonCam", false)
addLuaSprite("dadJsonCam", false)
addLuaSprite("gfJsonCam", false)

-- you can find the positions for these in [stageFileName].json

setProperty("boyfriendJsonCam.visible", false)
setProperty("gfJsonCam.visible", false)
setProperty("dadJsonCam.visible", false)
end

function onMoveCamera(focus)
    if SetCamCords == false then
	if focus == 'boyfriend' then
        char = 'boyfriend'
	end
    if focus == 'dad' then
        char = 'dad'
	end
    if focus == 'gf' then
        char = 'gf'
    end
end
end

function onCreatePost()
    CAMKEEP = getProperty('cameraSpeed')
end

function onUpdatePost()
    CPUuptime = CPUuptime - 1
    CPUdowntime = CPUdowntime - 1
    CPUlefttime = CPUlefttime - 1
    CPUrighttime = CPUrighttime - 1
    if CPUdowntime < 0 then
    DADdown = 0
    end
    if CPUuptime < 0 then
    DADup = 0
    end
    if CPUlefttime < 0 then
    DADleft = 0
    end
    if CPUrighttime < 0 then
    DADright = 0
    end
    BFx = BFright - BFleft
    BFy = BFdown - BFup
    DADx = DADright - DADleft
    DADy = DADdown - DADup
    x = BFx + DADx
    y = BFy + DADy
    if SetCamCords == true then
        setProperty('camFollow.x', CamPosX + x)
        setProperty('camFollow.y', CamPosY + y)
    end
    if SetCamCords == false then
        setProperty('camFollow.x', CHARCAMX + x)
        setProperty('camFollow.y', CHARCAMY + y)
        end
    end

function onUpdate()
    if char == 'dad' then
        PlayerCamMove = Player_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
        OpponenetCamMove = Opponent_Camera_Move_Amount *2 - getProperty('cameraSpeed') / 10
        GfCamMove = Opponent_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
    end
    if char == 'gf' then
        PlayerCamMove = Player_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
        OpponenetCamMove = Opponent_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
        GfCamMove = Opponent_Camera_Move_Amount *2 - getProperty('cameraSpeed') / 10
    end
    if char == 'boyfriend' then
        PlayerCamMove = Player_Camera_Move_Amount *2 - getProperty('cameraSpeed') / 10
        OpponenetCamMove = Opponent_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
        GfCamMove = Opponent_Camera_Move_Amount  - getProperty('cameraSpeed') / 13
    end
    if wait < 1 then
    canuarchive = false
    setProperty('cameraSpeed', CAMKEEP / 1.5)
    transitionCam = true
    end
    if transitionCam == true then
    if getProperty('cameraSpeed') > CAMKEEP then
    setProperty('cameraSpeed', CAMKEEP)
    canuarchive = true
    transitionCam  = false
    end
    if getProperty('cameraSpeed') < CAMKEEP then
        setProperty('cameraSpeed', getProperty('cameraSpeed') + 0.3)
    end
    if canuarchive == true then
        CAMKEEP = getProperty('cameraSpeed')
    end
    end
    if canuarchive == false then
    wait = wait - 1
    end
    if char == 'boyfriend' then
    CHARCAMX = getProperty('boyfriendJsonCam.x') + getProperty('boyfriend.x') + getProperty('boyfriend.width') * 0.5 - 150 - getProperty('boyfriend.cameraPosition')[1] + x
    CHARCAMY = getProperty('boyfriendJsonCam.y') + getProperty('boyfriend.y') + getProperty('boyfriend.height') * 0.5 - 100 + getProperty('boyfriend.cameraPosition')[2] + y
    end
    if char == 'gf' then
        CHARCAMX = getProperty('gfJsonCam.x') + getProperty('gf.x') + getProperty('gf.width') * 0.5 + getProperty('gf.cameraPosition')[1] + x
        CHARCAMY = getProperty('gfJsonCam.y') + getProperty('gf.y') + getProperty('gf.height') * 0.5 + getProperty('gf.cameraPosition')[2] + y
        end
    if char == 'dad' then
        CHARCAMX =  getProperty('dadJsonCam.x') + getProperty('dad.x') + getProperty('dad.width') * 0.5 + 150 + getProperty('dad.cameraPosition')[1] + x
        CHARCAMY =  getProperty('dadJsonCam.y') + getProperty('dad.y') + getProperty('dad.height') * 0.5 - 100 + getProperty('dad.cameraPosition')[2] + y
    end
        if keyReleased('right') and rightKey == 'onHold' then
            BFright = 0
            GFright = 0
            rightKey = 'null'
        end
        if keyReleased('left') and leftKey == 'onHold' then
            BFleft = 0
            GFleft = 0
            leftKey = 'null'
        end
        if keyReleased('up') and upKey == 'onHold' then
        BFup = 0
        GFup = 0
        upKey = 'null'
        end
        if keyReleased('down') and downKey == 'onHold' then
        BFdown = 0
        GFdown = 0
        downKey = 'null'
        end
        if keyPressed('right') and rightKey == 'onHold' then
            wait = 5
        end
        if keyPressed('down') and downKey == 'onHold' then
            wait = 5
        end
        if keyPressed('up') and upKey == 'onHold' then
            wait = 5
        end
        if keyPressed('left') and leftKey == 'onHold' then
            wait = 5
        end
    end


function onEvent(name, value1, value2)
    if name == 'Camera Follow Pos' then
        if value1 == '' and value2 == '' then
        SetCamCords = false
        else
        SetCamCords = true
        CamPosX = value1
        CamPosY = value2
        end
    end
end

function goodNoteHit(id, direction, noteType, Sustain)
    if direction == 0 then
        onNotePressed("left", "BF", noteType)
        wait = 5
    end
    if direction == 1 then
        onNotePressed("down", "BF", noteType)
        wait = 5
    end
    if direction == 2 then
        onNotePressed("up", "BF", noteType)
        wait = 5
    end
    if direction == 3 then
        onNotePressed("right", "BF", noteType)
        wait = 5
    end
end

function onNotePressed(dir, who, NOTE)
    NoteIDName = NOTE
    if NoteIDName == 'Ring Note' then
    Available = false
    else
    Available = true
    end
    if Available == true then
    if who == "BF" and dir == "left" then
    leftKey = 'onHold'
    BFleft = PlayerCamMove
    end
    if who == "BF" and dir == "right" then
    rightKey = 'onHold'
    BFright = PlayerCamMove
    end
    if who == "BF" and dir == "up" then
    upKey = 'onHold'
    BFup = PlayerCamMove
    end
    if who == "BF" and dir == "down" then
    downKey = 'onHold'
    BFdown = PlayerCamMove
    end
end
end

function opponentNoteHit(id, dir)
    if dir == 0 then
    OpponentNoteInput('Left')
    end
    if dir == 1 then
    OpponentNoteInput('Down')
    end
    if dir == 2 then
    OpponentNoteInput('Up')
    end
    if dir == 3 then
    OpponentNoteInput('Right')
    end
    end

function OpponentNoteInput(direction)
if direction == 'Left' then
    CPUlefttime = 11
    DADleft = OpponenetCamMove
    wait = 10
end
if direction == 'Down' then
    CPUdowntime = 11
    DADdown = OpponenetCamMove
    wait = 10
end
if direction == 'Up' then
    CPUuptime = 11
    DADup = OpponenetCamMove
    wait = 10
end
if direction == 'Right' then
    CPUrighttime = 11
    DADright = OpponenetCamMove
    wait = 10
end
end