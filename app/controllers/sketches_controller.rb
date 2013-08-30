class SketchesController < ApplicationController

  DATA_URL_PATTERN = /^data:([^;]*);\s*base64,\s*(.*)/

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
    sketch.image = data_url_to_image(json[:image])
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

  private

  def data_url_to_image(data_url)
    img = Image.new

    unless data_url.empty?
      data_url.scan(DATA_URL_PATTERN).map do |type, data|
        img.type = type
        img.data = Base64.decode64(data)
      end
    else
      Rails.logger.error('data_url was empty')
    end

    return img
  end

end