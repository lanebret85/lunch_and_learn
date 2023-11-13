require "rails_helper"

RSpec.describe CountriesService do
  describe "#get_all_countries" do
    it "returns an array of all country names in the world" do
      VCR.use_cassette("#get_all_countries") do
        countries = CountriesService.new.get_all_countries

        expect(countries).to be_an(Array)
        expect(countries.first).to be_a(String)
        expect(countries[50]).to be_a(String)
        expect(countries.last).to be_a(String)
      end
    end
  end

  describe "#get_random_country" do
    it "returns an array of all country names in the world" do
      VCR.use_cassette("#get_random_country_service") do
        country = CountriesService.new.get_random_country
        countries = CountriesService.new.get_all_countries

        expect(country).to be_a(String)
        expect(countries).to include(country)
      end
    end
  end

  describe "#get_capital_city_coordinates" do
    it "returns an array of coordinates with 2 float elements, the first for latitude and the second for longitude" do
      VCR.use_cassette("#get_capital_city_coordinates_service") do
        coordinates = CountriesService.new.get_capital_city_coordinates("France")

        expect(coordinates).to be_an(Array)
        expect(coordinates.count).to eq(2)
        expect(coordinates.first).to be_a(Float)
        expect(coordinates.last).to be_a(Float)
      end
    end
  end
end