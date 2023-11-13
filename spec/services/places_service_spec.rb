require "rails_helper"

RSpec.describe PlacesService do
  describe "#get_tourist_sites" do
    it "returns an array of tourist sites within a 10,000 meter radius of the given city" do
      VCR.use_cassette("#get_tourist_sites_service") do
        paris = City.new([46.0, 2.0])
        sites = PlacesService.new.get_tourist_sites(paris)

        expect(sites).to be_an(Array)
        expect(sites.first).to be_a(Hash)

        expect(sites.first).to have_key(:properties)
        expect(sites.first[:properties]).to be_a(Hash)

        expect(sites.first[:properties]).to have_key(:name)
        expect(sites.first[:properties][:name]).to be_a(String)

        expect(sites.first[:properties]).to have_key(:formatted)
        expect(sites.first[:properties][:formatted]).to be_a(String)

        expect(sites.first[:properties]).to have_key(:place_id)
        expect(sites.first[:properties][:place_id]).to be_a(String)
      end
    end
  end
end