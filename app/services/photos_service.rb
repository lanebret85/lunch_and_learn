class PhotosService
  def get_photos(query)
    response = conn.get do |req|
      req.params[:query] = query
    end
    parsed_photos = JSON.parse(response.body, symbolize_names: true)[:results]
    parsed_photos.first(10)
  end

  private

  def conn
    Faraday.new(url: "https://api.unsplash.com/search/photos/") do |f|
      f.params[:client_id] = Rails.application.credentials.unsplash[:api_key]
    end
  end
end