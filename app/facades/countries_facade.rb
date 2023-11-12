class CountriesFacade
  def get_random_country
    CountriesService.new.get_random_country
  end
end