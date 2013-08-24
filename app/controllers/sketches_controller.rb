class SketchesController < ApplicationController

  def index
    @sketches = Sketch.all
  end

  def show
    @sketch = Sketch.find(params[:id])
  end

end