class Sketch
  include MongoMapper::Document

  timestamps!
  key :title,   String,   :default => 'New Sketch'
  one :image

  def initialize(attrs = {})
    # It's extremely inconvenient to not have the image initialized by 
    # default.
    self.image ||= Image.new

    super(attrs)
  end

end
