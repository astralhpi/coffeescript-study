stdin = process.openStdin()
stdin.on 'data', (input) ->
    console.log input
console.log 'test'
