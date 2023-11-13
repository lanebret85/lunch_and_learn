require "rails_helper"

RSpec.describe City do
  describe "existance" do
    it "exists and has readable attributes" do
      city = City.new([46.0, 2.0])

      expect(city).to be_a(City)
      expect(city.latitude).to eq(46.0)
      expect(city.longitude).to eq(2.0)
    end
  end
end