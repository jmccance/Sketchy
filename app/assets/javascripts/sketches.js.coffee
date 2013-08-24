
canvas = $('canvas')
title = $('canvas').data('title')
g = canvas[0].getContext('2d')
canvas = canvas[0]

pos = x: 0, y: Math.floor(canvas.height / 2)
mid = Math.floor(canvas.height / 2)

draw = () ->
  pos.x = (pos.x + canvas.width / (33 * 10)) % canvas.width
  pos.y = mid + Math.sin(pos.x / 100) * canvas.height / 4

  g.fillStyle = '#2a55aa'
  g.fillRect(0, 0, canvas.width, canvas.height)

  g.strokeStyle = 'black'
  g.font = '24pt Times'
  g.fillText(title, pos.x, pos.y) 
  g.strokeText(title, pos.x, pos.y)

setInterval(draw, 33)