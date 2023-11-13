class Resource
  attr_reader :id,
              :video,
              :images,
              :country

  def initialize(video, images, country)
    @id = nil
    @country = country
    @video = video
    @images = images
  end
end