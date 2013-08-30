##
# Models a Sketch, suitable for pushing to the backend.
#
# A Sketch, as far as the front-end is concerned, consists
# of a title and the raster data as a base64-encoded string.
class Sketch
  constructor: (@id, @title, @data) ->

class SketchService
  constructor: (@sketchUrl) ->

  save: (sketch) ->
    console.log(sketch)

##
# Provides drawing functionality on an injected <canvas> element.
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

  toPng: ->
    @elt.toDataURL()

  loadFrom: (image) ->
    @g.clearRect(0, 0, @elt.width, @elt.height)
    @g.drawImage(image, 0, 0)

# Knockout View Controller

class SketchyApp
  constructor: (@sketchSvc, @container, @canvasElt) ->
    @canvas = new Canvas(@canvasElt[0])
    @sketch = @_getSketchFromContainer()

    @fgColor = ko.computed
        read: => @canvas.color
        write: (color) => @canvas.color = color
    
    @sketchTitle = ko.computed
        read: => @sketch.title
        write: (title) => @sketch.title = title

  save: () ->
    @sketch.data = @canvas.toPng()
    @sketchSvc.save(@sketch)

  _getSketchFromContainer: -> 
    new Sketch(@container.data('sketch-id'), @container.data('sketch-title'))

# Apply bindings appropriate to the page

canvas = $('#canvas')[0]

if canvas? then ko.applyBindings(
  new SketchyApp(
    new SketchService
    $('#sketchy-app'),
    $('#canvas')
  )
)