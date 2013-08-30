class Image
  include MongoMapper::EmbeddedDocument

  key :type,      String, :default => 'image/png'
  key :data,      Binary, :default => ''

  def to_data_url
    "data:#{self.type};base64,#{Base64.strict_encode64(self.data.to_s)}"
  end

end