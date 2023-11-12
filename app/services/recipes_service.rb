class RecipesService
  def get_recipes(query)
    response = conn.get do |req|
      req.params['q'] = query
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.edamam.com/api/recipes/v2") do |f|
      f.headers['Content-Type'] = 'application/json'
      f.headers['Accept'] = 'application/json'
      f.params['app_id'] = Rails.application.credentials.edamam[:app_id]
      f.params['app_key'] = Rails.application.credentials.edamam[:app_key]
      f.params['type'] = 'public'
    end
  end
end