require "rails_helper"

RSpec.describe "Places - Tourist Sites Index" do
  describe "When the backend receives a request for tourist sites with a country paramter provided" do
    it "makes a request to the RESTcountries API and receives latitude and longitude for the capital city of that country. Then, it makes a request to the Places API for tourist sites within a 1000-meter radius of the city associated to the country. Finally, it sends the list of those tourist sites to the frontend" do
      VCR.use_cassette("Paris tourist sites") do
        get "/api/v1/tourist_sites", params: { country: 'France' }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        tourism_hash = JSON.parse(response.body, symbolize_names: true)

        expect(tourism_hash).to be_a(Hash)
        expect(tourism_hash).to have_key(:data)

        tourist_sites = tourism_hash[:data]

        expect(tourist_sites).to be_an(Array)

        site_1 = tourist_sites.first

        expect(site_1).to be_a(Hash)

        expect(site_1).to have_key(:id)
        expect(site_1[:id]).to eq(nil)

        expect(site_1).to have_key(:type)
        expect(site_1[:type]).to eq("tourist_site")

        expect(site_1).to have_key(:attributes)
        expect(site_1[:attributes]).to be_a(Hash)

        site_1_info = site_1[:attributes]

        expect(site_1_info).to have_key(:name)
        expect(site_1_info[:name]).to be_a(String)

        expect(site_1_info).to have_key(:address)
        expect(site_1_info[:address]).to be_a(String)

        expect(site_1_info).to have_key(:place_id)
        expect(site_1_info[:place_id]).to be_a(String)
      end
    end
  end
end