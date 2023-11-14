require "rails_helper"

RSpec.describe "User Favorites Index" do
  describe "When the backend receives a GET request for recipe favorites with a valid api key query parameter" do
    it "confirms that a user with the api_key passed in exists. If the user exists, it sends a response to the frontend with a list of their favorited recipes with each recipe's details, including id, recipe_title, recipe_link, country, and created_at" do
      user = User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")
      user.favorites.create!(country: "thailand", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com/crab_fried_rice", created_at: "Tue, 14 Nov 2023 18:33:13.746634000 UTC +00:00")

      get "/api/v1/favorites", params: { api_key: "jgn983hy48thw9begh98h4539h4" }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      favorites_hash = JSON.parse(response.body, symbolize_names: true)

      expect(favorites_hash).to be_a(Hash)
      expect(favorites_hash).to have_key(:data)

      favorites = favorites_hash[:data]

      expect(favorites).to be_an(Array)

      favorite = favorites.first

      expect(favorite).to have_key(:id)
      expect(favorite[:id]).to be_a(String)

      expect(favorite).to have_key(:type)
      expect(favorite[:type]).to eq("favorite")

      expect(favorite).to have_key(:attributes)
      expect(favorite[:attributes]).to be_a(Hash)

      favorite_info = favorite[:attributes]

      expect(favorite_info).to have_key(:recipe_title)
      expect(favorite_info[:recipe_title]).to be_a(String)
      expect(favorite_info[:recipe_title]).to eq("Crab Fried Rice (Khaao Pad Bpu)")

      expect(favorite_info).to have_key(:recipe_link)
      expect(favorite_info[:recipe_link]).to be_a(String)
      expect(favorite_info[:recipe_link]).to eq("https://www.tastingtable.com/crab_fried_rice")

      expect(favorite_info).to have_key(:country)
      expect(favorite_info[:country]).to be_a(String)
      expect(favorite_info[:country]).to eq("thailand")

      expect(favorite_info).to_not have_key(:api_key)
      expect(favorite_info).to_not have_key(:user)
      expect(favorite_info).to_not have_key(:user_id)
    end
  end

  describe "When the backend receives a GET request for recipe favorites with an invalid api key query parameter" do
    it "sends a response to the frontend with a 404 status code and an error message that no user was found with that api key" do
      user = User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")
      user.favorites.create!(country: "thailand", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com/crab_fried_rice", created_at: "Tue, 14 Nov 2023 18:33:13.746634000 UTC +00:00")

      get "/api/v1/favorites", params: { api_key: "I28me0hJk44pb49N0M22uaDn312mf77q" }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:error]).to eq("User not found with given API key")
      expect(parsed_response[:status]).to eq(404)
    end
  end

  describe "When the backend receives a GET request for recipe favorites with a valid api key query parameter, but the user does not have any favorited recipes saved" do
    it "sends a response to the frontend with a 200 status code and a json hash with a name/key :data pointing to an empty array" do
      User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")

      get "/api/v1/favorites", params: { api_key: "jgn983hy48thw9begh98h4539h4" }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      favorites_hash = JSON.parse(response.body, symbolize_names: true)

      expect(favorites_hash).to be_a(Hash)
      expect(favorites_hash).to have_key(:data)
      expect(favorites_hash[:data]).to eq([])
    end
  end
end