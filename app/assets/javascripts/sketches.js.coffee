class Canvas
  constructor: (@elt) ->
    @g = @elt.getContext('2d')
    @color = 'black'
    @pos =
      x: null
      y: null
    @state = 'idle'

    @elt.addEventListener('mousedown', (e) => @onMouseDown(e))
    @elt.addEventListener('mousemove', (e) => @onMouseMove(e))
    @elt.addEventListener('mouseup',   (e) => @onMouseUp(e))

  origin: () ->
    rect = @elt.getBoundingClientRect()
    { x: rect.left, y: rect.top }

  drawLine: (p0, p1) ->
    o = @origin()
    @g.beginPath()
    @g.moveTo(p0.x - o.x, p0.y - o.y)
    @g.lineTo(p1.x - o.x, p1.y - o.y)
    @g.stroke()

  onMouseDown: (e) ->
    @pos =
    x: e.x
    y: e.y
    @state = 'dragging'

  onMouseMove: (e) ->
    if @state == 'dragging'
      @g.strokeStyle = @color
      @g.lineWidth = 4
      @g.lineCap = 'round'
      @drawLine(@pos, e)
      @pos =
        x: e.x
        y: e.y

  onMouseUp: (e) ->
    @state = 'idle'

# Knockout Experiments

class SketchyApp
  constructor: (@canvasElt) ->
    @canvas = new Canvas(@canvasElt)
    @fgColor = ko.computed
        read: () => @canvas.color
        write: (color) =>
          @canvas.color = color

ko.applyBindings(new SketchyApp($('#canvas')[0]))