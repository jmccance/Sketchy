##
# Models a Sketch, suitable for pushing to the backend.
#
# A Sketch, as far as the front-end is concerned, consists
# of a title and the raster data as a base64-encoded string.
class Sketch
  constructor: (@id, @title, @image) ->

##
# Service to handle saving a given sketch. In the future, may be fleshed out
# to serve a more generalized CRUDdy role.
class SketchService
  constructor: (@sketchPath) ->

  save: (sketch) ->
    $.ajax
      type: 'PUT'
      url: @sketchPath
      contentType: 'application/json'
      data: JSON.stringify({sketch: sketch})

##
# Provides drawing functionality on an injected <canvas> element.
class Canvas
  constructor: (@elt, image) ->
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

    @g.drawImage(image, 0, 0)

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

  ##
  # @container - the jQuery element containing the Sketchy application
  # @canvasElt - the jQuery element for the canvas we're drawing on
  constructor: (@container, @canvasElt) ->
    @sketchSvc = @_getSketchServiceFromContainer()

    @sketch = @_getSketchFromContainer()
    @canvas = new Canvas(
        @canvasElt[0],
        # Image doesn't seem to have a way to set the source in the
        # constructor, hence the function oddity.
        do => 
          img = new Image
          img.src = @sketch.image
          img
    )
    
    @sketchTitle = ko.computed
        read: => @sketch.title
        write: (title) => @sketch.title = title

    @fgColor = ko.computed
        read: => @canvas.color
        write: (color) => @canvas.color = color

  setColor: (data, e) ->
    # TODO Revisit color-picker implementation.
    # Using the class name directly is not great way to handle setting the 
    # color, since it creates a tight coupling between the classes used in 
    # the view and the pen color.
    @fgColor(e.target.className)
    console.log(@fgColor())

  save: () ->
    @sketch.image = @canvas.toPng()
    @sketchSvc.save(@sketch)

  _getSketchFromContainer: -> 
    new Sketch(
      @container.data('sketch-id'), 
      @container.data('sketch-title'),
      @container.data('sketch-image')
    )

  _getSketchServiceFromContainer: -> 
    new SketchService(@container.data('sketch-path'))

# Apply bindings appropriate to the page

canvas = $('#canvas')[0]

if canvas? then ko.applyBindings(
  new SketchyApp(
    $('#sketchy-app'),
    $('#canvas')
  )
)