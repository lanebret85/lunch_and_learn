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
end