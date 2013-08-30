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

    respond_to do |format|
      format.html
      format.json { render json: @sketch }
    end
  end

  def edit
  end

  def update
    json = params[:sketch]
    sketch = Sketch.find(json[:id])

    sketch.title = json[:title]
    # TODO Update other fields

    sketch.save

    respond_to do |format|
      format.json { render json: sketch}
    end
  end

  def destroy
    sketch = Sketch.find(params[:id])
    sketch.destroy()

    respond_to do |format|
      format.html { redirect_to sketches_url() }
    end
  end 

end