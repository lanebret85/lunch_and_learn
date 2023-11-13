class Video
  attr_reader :title,
              :youtube_video_id

  def initialize(video_info)
    @title = video_info[:snippet][:title]
    @youtube_video_id = video_info[:id][:videoId]
  end
end