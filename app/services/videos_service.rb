class VideosService
  def get_mr_history_video(query)
    response = conn.get do |req|
      req.params[:channel_id] = "UCluQ5yInbeAkkeCndNnUhpw"
      req.params[:type] = "video"
      req.params[:q] = query
    end
    parsed_videos = JSON.parse(response.body, symbolize_names: true)[:items]
    parsed_videos.first
  end

  private

  def conn
    Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |f|
      f.params[:key] = Rails.application.credentials.youtube[:api_key]
      f.params[:part] = "snippet"
    end
  end
end