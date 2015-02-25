class Image
  include MongoMapper::EmbeddedDocument

  key :type,      String, :default => 'image/png'
  key :data,      Binary, :default => Base64.strict_decode64(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAAxJRE' +
      'FUCB1j+P//PwAF/gL+n8otEwAAAABJRU5ErkJggg==')

  def to_data_url
    "data:#{self.type};base64,#{Base64.strict_encode64(self.data.to_s)}"
  end

end
