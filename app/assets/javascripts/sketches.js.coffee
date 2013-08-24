
canvas = $('canvas')
title = $('canvas').data('title')
g = canvas[0].getContext('2d')
canvas = canvas[0]

g.fillStyle = '#2a55aa'
g.fillRect(0, 0, canvas.width, canvas.height)

g.strokeStyle = ''
g.font = '24pt Times'
g.strokeText(title, 100, 100)