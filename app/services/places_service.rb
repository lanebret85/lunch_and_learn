class PlacesService
  def get_tourist_sites(city)
    response = conn.get do |req|
      req.params[:categories] = "tourism.sights"
      req.params[:filter] = "circle:#{city.longitude},#{city.latitude},10000"
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:features]
  end
  
  private

  def conn
    Faraday.new(url: "https://api.geoapify.com/v2/places") do |f|
      f.params[:apiKey] = Rails.application.credentials.places[:api_key]
    end
  end
end