require "rails_helper"

RSpec.describe RecipesFacade do
  describe "#get_recipes" do
    it "returns an array of Recipe objects" do
      VCR.use_cassette("#get_recipes_facade") do
        recipes = RecipesFacade.new.get_recipes('thailand')

        expect(recipes).to be_an(Array)
        expect(recipes.first).to be_a(Recipe)
        expect(recipes.last).to be_a(Recipe)
        expect(recipes.last.country).to eq('thailand')
      end
    end
  end
end