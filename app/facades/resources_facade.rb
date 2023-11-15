class ResourcesFacade
  def get_resource(query)
    Resource.new(get_video(query), get_photos(query), query)
  end

  def get_video(query)
    video = VideosService.new.get_mr_history_video(query)
    if video == nil
      {}
    else
      Video.new(video)
    end
  end

  def get_photos(query)
    photos = PhotosService.new.get_photos(query)
    if photos.empty?
      []
    else
      photos.map do |photo|
        Photo.new(photo)
      end
    end
  end
end