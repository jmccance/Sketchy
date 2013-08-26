
canvas = $('#canvas')
title = $('#canvas').data('title')
g = canvas[0].getContext('2d')
canvas = canvas[0]

startTime = Date.now()
elapsedTime = () -> Date.now() - startTime

startPos =
	x: 0
	y: Math.floor(canvas.height / 2)

pos =
  x: () -> Math.floor(startPos.x + elapsedTime() * canvas.width / 5000) % canvas.width
  y: () -> Math.floor(startPos.y + (canvas.height / 2) * Math.sin(elapsedTime() / canvas.width))
  # x: () -> Math.floor(startPos + elapsedTime * (5000 / canvas.width)) % canvas.width
  # y: () -> startPos.y + Math.sin(elapsedTime) * canvas.height / 4

draw = () ->
  g.fillStyle = '#2a55aa'
  g.fillRect(0, 0, canvas.width, canvas.height)

  g.fillStyle = 'white'
  g.font = '24pt Helvetica'
  g.fillText(title, pos.x(), pos.y())
  g.fillText(title, pos.x() - canvas.width, pos.y())

  g.font = '10pt monospace'
  g.fillText("(#{pos.x()}, #{pos.y()})", 0, 10)

setInterval(draw, 33)