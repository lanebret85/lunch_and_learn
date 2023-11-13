class Photo
  attr_reader :alt_tag,
              :url

  def initialize(photo_info)
    @alt_tag = photo_info[:alt_description]
    @url = photo_info[:urls][:raw]
  end
end