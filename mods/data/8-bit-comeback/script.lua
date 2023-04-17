local songList = {'lurkingLock','loreLock','blubberdixLock','goldenLock','performanceLock','biteLock','trappedLock','gofishLock','watchfulLock','restlessLock','beatboxLock','showtimeLock','manLock','followedLock','fazfuckLock','criminalLock','millerLock','helpwantedLock','birthdayboyLock','batteriesLock','_8bitcomebackLock'}

function onCreatePost()
for i = 1, #songList do
debugPrint(getPropertyFromClass('FreeplaySaves', songList[i]))
end
end