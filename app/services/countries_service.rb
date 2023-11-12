class CountriesService
  def get_random_country
    get_all_countries.sample
  end

  def get_all_countries
    response = conn.get("all")
    parsed_response_body = JSON.parse(response.body, symbolize_names: true)
    parsed_response_body.map do |country|
      country[:name][:common]
    end
  end

  private

  def conn
    Faraday.new(url: "https://restcountries.com/v3.1/")
  end
end