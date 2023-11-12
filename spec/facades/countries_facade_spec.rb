require "rails_helper"

RSpec.describe CountriesFacade do
  describe "#get_random_country" do
    it "returns a string that contains the name of a country selected randomly from all countries" do
      VCR.use_cassette("#get_random_country_facade") do
        country = CountriesFacade.new.get_random_country

        expect(country).to be_a(String)
      end
    end
  end
end