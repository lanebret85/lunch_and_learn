require "rails_helper"

RSpec.describe Recipe do
  describe "existance" do
    it "exists and has readable attributes" do
      recipe = Recipe.new(
        {
          label: "Chicken Nuggets",
          url: "www.chicken_nuggets.com",
          image: "lookatthechickennuggets.jpg"
        }
      )

      expect(recipe.id).to be(nil)
      expect(recipe.title).to eq("Chicken Nuggets")
      expect(recipe.url).to eq("www.chicken_nuggets.com")
      expect(recipe.country).to eq("")
      expect(recipe.image).to eq("lookatthechickennuggets.jpg")
    end
  end
end