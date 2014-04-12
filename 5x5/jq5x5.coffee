grid = dictionary = currPlayer = player1 = player2 = selectedCoordinates = null

newGame = ->
    grid = new grid
    dictionary = new Dictionary(OWL2, grid)
    currPlayer = player1 = new Player('Player 1', dictionary)
    player2 = new Player('Player 2', dictionary)
    drawTiles()

    player1.num = 1
    player2.num = 2
    for player in [player1, player2]
        $("#p#{player.num}name").html player.name
        $("#p#{player.num}score").html 0
    showMessage 'firstTile'

drawTiles = ->
    gridHtml = ''
    for x in [0...grid.tiles.length]
        gridHtml += '<ul>'
        for y in [0...grid.tiles.length]
            gridHtml += "<li id='tile#{x}_#{y}'>#{grid.tiles[x][y]}</li>"
        gridHtml += '</ul>'
    $('#grid').html gridHtml

tileClick = ->
    $tile = $(this)
    if $tile.hasClass 'selected'
        # 원상태로 되돌림
        selectedCoordinates = null
        $tile.removeClass 'selected'
        showMessage 'firstTile'
    else
        $tile.addClass 'selected'
        [x, y] = @id.match(/(\d+)_(\d+)/)[1..]
        selectTile x, y

selectTile = (x, y) ->
    if selectedCoordinates is null
        selectedCoordinates = {x1: x, y1: y}
        showMessage 'secondTile'
    else
        selectedCoordinates.x2 = x
        selectedCoordinates.y2 = y
        $('#grid li').removeClass 'selected'
        doMove()

doMove = ->
    {moveSore, newWords} = currPlayer.makeMove selectedCoordinates
    if moveSore is 0
        $notice = $("${currPlayer.name} 이번 차례에서 단어가 만들어지지 않았다.")
    else
        $notice = $("""
            <p class="notice">
                #{currPlayer} 다음 ${newWords.length}개의 단어(들)이 만들어졌다.<br/>
                <b>#{newWords.join(', ')}</b><br />
                획득 포인트: <b>#{moveSocre / newWords.length}x#{newWords.length} =
                #{moveScore}</b>
            </p>
        """)
    showThenFade $notice
    # endTurn()

showThenFade = ($elem) ->
    $ele.insertAfter $('#grid')
    animationTarget = opacity: 0, height: 0, padding: 0
    $elem.delay(5000).animate animationTarget, 500, -> $elem.remove()

$(document).ready ->
    newGame()
    $('#grid li').live 'click', tileClick