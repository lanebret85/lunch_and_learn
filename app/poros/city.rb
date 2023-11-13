class City
  attr_reader :latitude,
              :longitude
              
  def initialize(city_coordinates)
    @latitude = city_coordinates.first
    @longitude = city_coordinates.last
  end
end