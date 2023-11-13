require "rails_helper"

RSpec.describe TouristSite do
  describe "existance" do
    it "exists and has readable attributes" do
      site_properties = {
        name: "Eiffel Tower",
        formatted: "1 Eiffel Tower Street, Paris, France",
        place_id: "987654321"
      }
      site = TouristSite.new(site_properties)

      expect(site).to be_a(TouristSite)
      expect(site.id).to be(nil)
      expect(site.name).to eq("Eiffel Tower")
      expect(site.address).to eq("1 Eiffel Tower Street, Paris, France")
      expect(site.place_id).to eq("987654321")
    end
  end
end