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
    @elt.addEventListener('mouseover', (e) => @onMouseEnter(e))

  getRelativeCoords: (p) ->
    rect = @elt.getBoundingClientRect()
    origin = { x: rect.left, y: rect.top }
    { x: p.x - origin.x, y: p.y - origin.y }

  drawLine: (p0, p1) ->
    @g.beginPath()
    @g.moveTo(p0.x, p0.y)
    @g.lineTo(p1.x, p1.y)
    @g.stroke()

  onMouseEnter: (e) ->
    @pos = @getRelativeCoords(e)

  onMouseDown: (e) ->
    @state = 'dragging'
    @pos = @getRelativeCoords(e)

  onMouseMove: (e) ->
    if @state == 'dragging'
      pt = @getRelativeCoords(e)
      @g.strokeStyle = @color
      @g.lineWidth = 4
      @g.lineCap = 'round'
      @drawLine(@pos, pt)
      @pos = pt

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

# Apply bindings appropriate to the page
canvas = $('#canvas')[0]
if canvas? then ko.applyBindings(new SketchyApp($('#canvas')[0]))