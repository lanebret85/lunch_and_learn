require "rails_helper"

RSpec.describe TourismFacade do
  describe "#get_tourist_sites" do
    it "returns an array of TouristSite objects" do
      VCR.use_cassette("#get_tourist_sites_facade") do
        sites = TourismFacade.new.get_tourist_sites('France')

        expect(sites).to be_an(Array)
        expect(sites.first).to be_a(TouristSite)
        expect(sites.last).to be_a(TouristSite)
      end
    end
  end

  describe "#get_capital_city_coordinates" do
    it "returns a City object" do
      VCR.use_cassette("#get_capital_city_coordinates_facade") do
        city = TourismFacade.new.get_capital_city_coordinates('France')

        expect(city).to be_a(City)
      end
    end
  end
end