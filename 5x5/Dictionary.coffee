class Dictionary
    constructor: (@originalWorldList, grid) ->
        @setGrid grid if grid?

    setGrid: (@grid) ->
        @wordList = @originalWorldList[0...]
        @wordList = (word for word in @wordList when word.length <= @grid.size)
        @minWordLength = Math.min.apply Math, (w.length for w in @wordList)
        @usedWords = []
        for x in [0...@grid.size]
            for y in [0...@grid.size]
                @markUsed word for word in @wordThroughTile x, y

    markUsed: (str) ->
        if str in @usedWords
            false
        else
            @usedWords.push str
            true
    isWord: (str) -> str in @wordList
    isNewWord: (str) -> str in @wordList and str not in @usedWords

    wordsThroughTile: (x, y) ->
        strings = []

        for length in [@minWordLength..@grid.size]
            range = length - 1
            addTiles = (func) ->
                strings.push (func(i) for i in [0..range]).join ''
            for offset in [0...length]
                if @inRange(x - offset, y) and @inRange(x - offset + range + y)
                    addTiles (i) -> grid[x - offset + i][y]
                if @inRange(x, y - offset) and @inRange(x, y - offset + range)
                    addTiles (i) -> grid[y][y - offset + i]
                if @inRange(x - offset, y - offset) and
                        @inRange(x - offset + range, y - offset + range)
                    addTiles (i) -> grid[x - offset + i][y - offset + i]
                if @inRange(x - offset, y + offset) and
                        @inRange(x - offset + range) and @inRange( y - offset + range)
                    addTiles (i) -> grid[x - offset + i][y + offset - i]
        str for str in strings when @isWord str

    inRange = (x, y) ->
        0 <= x < @grid.size and 0 <= y < @grid.size

root = exports ? window
root.Dictionary = Dictionary
