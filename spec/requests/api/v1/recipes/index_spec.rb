require "rails_helper"

RSpec.describe "Recipes Index" do
  describe "When the backend receives a request for recipes with a country paramter provided" do
    it "makes a request to the Edamam API and receives recipe data associated to the country as a response, and then it sends a response to the frontend with the data it received from Edamam" do
      VCR.use_cassette("thailand recipes") do
        get "/api/v1/recipes", params: { country: 'thailand' }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        recipes_hash = JSON.parse(response.body, symbolize_names: true)

        expect(recipes_hash).to be_a(Hash)
        expect(recipes_hash).to have_key(:data)

        recipes = recipes_hash[:data]

        expect(recipes).to be_an(Array)

        recipe_1 = recipes.first

        expect(recipe_1).to be_a(Hash)

        expect(recipe_1).to have_key(:id)
        expect(recipe_1[:id]).to eq(nil)

        expect(recipe_1).to have_key(:type)
        expect(recipe_1[:type]).to eq("recipe")

        expect(recipe_1).to have_key(:attributes)
        expect(recipe_1[:attributes]).to be_a(Hash)

        recipe_1_info = recipe_1[:attributes]

        expect(recipe_1_info).to have_key(:title)
        expect(recipe_1_info[:title]).to be_a(String)

        expect(recipe_1_info).to have_key(:url)
        expect(recipe_1_info[:url]).to be_a(String)

        expect(recipe_1_info).to have_key(:country)
        expect(recipe_1_info[:country]).to be_a(String)

        expect(recipe_1_info).to have_key(:image)
        expect(recipe_1_info[:image]).to be_a(String)

        expect(recipe_1_info).to_not have_key(:from)
        expect(recipe_1_info).to_not have_key(:to)
        expect(recipe_1_info).to_not have_key(:count)
        expect(recipe_1_info).to_not have_key(:_links)
        expect(recipe_1_info).to_not have_key(:uri)
        expect(recipe_1_info).to_not have_key(:source)
        expect(recipe_1_info).to_not have_key(:yield)
        expect(recipe_1_info).to_not have_key(:diet_labels)
        expect(recipe_1_info).to_not have_key(:cautions)
        expect(recipe_1_info).to_not have_key(:ingredientLines)
        expect(recipe_1_info).to_not have_key(:ingredients)
        expect(recipe_1_info).to_not have_key(:calories)
        expect(recipe_1_info).to_not have_key(:totalCO2Emissions)
        expect(recipe_1_info).to_not have_key(:co2EmissionsClass)
        expect(recipe_1_info).to_not have_key(:totalWeight)
        expect(recipe_1_info).to_not have_key(:totalTime)
        expect(recipe_1_info).to_not have_key(:cuisineType)
        expect(recipe_1_info).to_not have_key(:mealType)
        expect(recipe_1_info).to_not have_key(:totalNutrients)
        expect(recipe_1_info).to_not have_key(:totalDaily)
        expect(recipe_1_info).to_not have_key(:digest)
      end
    end
  end

  describe "When the backend receives a request for recipes without a country paramter provided" do
    it "uses a random country name to make a request to the Edamam API and still is able to provide a successful response to the frontend" do
      get "/api/v1/recipes"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe "When the backend receives a request for recipes associated to a country that does not return any results from the Edamam API or the backend has to generate a random country and that country does not return any Edamam results" do
    it "sends a response to the frontend that is still a json hash with the key/name 'data' pointing to an empty array" do
      VCR.use_cassette("liberia recipes") do
        get "/api/v1/recipes", params: { country: "liberia" }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        recipes_hash = JSON.parse(response.body, symbolize_names: true)

        expect(recipes_hash).to be_a(Hash)
        expect(recipes_hash).to have_key(:data)

        recipes = recipes_hash[:data]

        expect(recipes).to be_an(Array)
        expect(recipes).to be_empty
      end
    end
  end
end