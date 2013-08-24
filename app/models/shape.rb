class Shape
  include MongoMapper::EmbeddedDocument
  
  key :color, String
end