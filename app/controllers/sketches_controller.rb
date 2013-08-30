class SketchesController < ApplicationController

  def index
    @sketches = Sketch.all
  end

  def new
    @sketch = Sketch.new
    @sketch.save
    redirect_to sketch_url(@sketch)
  end

  def create
  end

  def show
    @sketch = Sketch.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    sketch = Sketch.find(params[:id])
    sketch.destroy()
    if request.format.html?
      redirect_to sketches_url()
    end
  end 

end