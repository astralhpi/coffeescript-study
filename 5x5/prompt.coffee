stdin = process.openStdin()
stdin.setEncoding 'utf8'

inputCallback = null
stdin.on 'data', (input) -> inputCallback input

promptForTile1 = ->
    console.log "첫 번째 타일 좌표를 입력하기 바랍니다."
    inputCallback = (input) ->
        promptForTile2() if strToCoordinates input

promptForTile2 = ->
    console.log "두 번째 타일 좌표를 입력하기 바랍니다."
    inputCallback = (input) ->
        if strToCoordinates input
            console.log "타일 교환...완료!"
            promptForTile1()

GRID_SIZE = 5
inRange = (x, y) ->
    0 <= x < GRID_SIZE and 0 <= y < GRID_SIZE

isInteger = (num) ->
    num is Math.round(num)

strToCoordinates = (input) ->
    halves = input.split(',')
    if halves.length is 2
        x = parseFloat halves[0]
        y = parseFloat halves[1]
        if !isInteger(x) or !isInteger(y)
            console.log "각 좌표는 정수값이어야 한다."
        else if not inRange x - 1, y - 1
            console.log "각 좌표값의 범위는 1에서부터 #{GRID_SIZE}까지다."
        else
            {x, y}
    else
        console.log '입력 형식은 `x, y`이다.'

console.log "5x5 단어 게임에 오신 것을 환영합니다!"
promptForTile1()
