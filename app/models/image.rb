class Image
  include MongoMapper::EmbeddedDocument

  key :type,      String, :default => 'image/png'
  key :data,      Binary, :default => ''

  def to_data_url
    # NYI
    ""
  end

end