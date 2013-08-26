class Sketch
  include MongoMapper::Document

  timestamps!
  key :title,   String,   :default => 'New Sketch'
  many :shapes

end
