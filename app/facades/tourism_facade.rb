class TourismFacade
  def get_tourist_sites(country)
    tourist_sites = PlacesService.new.get_tourist_sites(get_capital_city_coordinates(country))
    tourist_sites.map do |site|
      TouristSite.new(site[:properties])
    end
  end

  def get_capital_city_coordinates(country)
    coordinates = CountriesService.new.get_capital_city_coordinates(country)
    City.new(coordinates)
  end
end