require "rails_helper"

RSpec.describe Recipe do
  describe "existance" do
    it "exists and has readable attributes" do
      recipe_info = {
        label: "Chicken Nuggets",
        url: "www.chicken_nuggets.com",
        image: "lookatthechickennuggets.jpg"
      }

      recipe = Recipe.new(recipe_info, "Nuggieland")

      expect(recipe.id).to be(nil)
      expect(recipe.title).to eq("Chicken Nuggets")
      expect(recipe.url).to eq("www.chicken_nuggets.com")
      expect(recipe.country).to eq("Nuggieland")
      expect(recipe.image).to eq("lookatthechickennuggets.jpg")
    end
  end
end