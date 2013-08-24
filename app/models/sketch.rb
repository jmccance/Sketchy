class Sketch
  include MongoMapper::Document

  timestamps!
  key :title,         String
  many :shapes

end
