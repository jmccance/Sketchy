class Sketch
  include MongoMapper::Document

  timestamps!
  key :title,   String,   :default => 'New Sketch'
  one :image

  def initialize(attrs = {})
    self.image ||= Image.new
  end
  
  # before_create :init_image

  # private

  #   def init_image
  #     self.image ||= Image.new
  #   end

end
