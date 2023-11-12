require "rails_helper"

RSpec.describe RecipesService do
  describe "#get_recipes_service" do
    it "returns an array of recipes related to the query argument" do
      VCR.use_cassette("#get_recipes") do
        recipes = RecipesService.new.get_recipes('thailand')

        expect(recipes).to be_a(Hash)
        expect(recipes).to have_key(:hits)
        expect(recipes[:hits]).to be_an(Array)
        expect(recipes[:hits].first).to be_a(Hash)
        expect(recipes[:hits].first).to have_key(:recipe)
        expect(recipes[:hits].first[:recipe]).to be_a(Hash)
        expect(recipes[:hits].first[:recipe]).to have_key(:label)
        expect(recipes[:hits].first[:recipe]).to have_key(:url)
        expect(recipes[:hits].first[:recipe]).to have_key(:image)
        expect(recipes[:hits].last).to be_a(Hash)
        expect(recipes[:hits].last).to have_key(:recipe)
        expect(recipes[:hits].last[:recipe]).to be_a(Hash)
        expect(recipes[:hits].last[:recipe]).to have_key(:label)
        expect(recipes[:hits].last[:recipe]).to have_key(:url)
        expect(recipes[:hits].last[:recipe]).to have_key(:image)
      end
    end
  end
end