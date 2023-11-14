require "rails_helper"

RSpec.describe "Favorites Create" do
  describe "When the backend receives a POST request to 'favorite' a recipe with a hash of recipe information - including country, recipe_link, recipe_title, and a user's api_key - in the request body" do
    it "confirms that all required informtion has been sent and that a user with the api_key passed in exists. If all necessary information is validated, it creates a new record in the favorites table in the database with the user_id matching the id of the user where the given api_key matched the api_key column in the users table, and it sends a response to the frontend with a success message 'Favorite added successfully'" do
      User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")

      VCR.use_cassette("favorite create") do
        favorite_params = {
          "api_key": "jgn983hy48thw9begh98h4539h4",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/crab_fried_rice",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        post "/api/v1/favorites", params: favorite_params, as: :json

        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:success]).to eq("Favorite added successfully")
      end
    end
  end

  describe "When the backend receives a POST request for a favorite with a hash of favorite information that includes an invalid api_key in the request body" do
    it "sends a response to the frontend with a 404 status code and an error message that no user was found with that api key" do
      User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")

      VCR.use_cassette("no user with api key") do
        favorite_params = {
          "api_key": "I28me0hJk44pb49N0M22uaDn312mf77q",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/crab_fried_rice",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        post "/api/v1/favorites", params: favorite_params, as: :json

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:error]).to eq("User not found with given API key")
        expect(parsed_response[:status]).to eq(404)
      end
    end
  end

  describe "When the backend receives a POST request for a favorite with a hash of favorite information that is missing a required field in the request body" do
    it "sends a response to the frontend with a 400 status code and an error message that [missing field] can't be blank" do
      VCR.use_cassette("missing favorite information") do
        User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "jgn983hy48thw9begh98h4539h4")

        favorite_params = {
          "api_key": "jgn983hy48thw9begh98h4539h4",
          "recipe_link": "https://www.tastingtable.com/crab_fried_rice",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        post "/api/v1/favorites", params: favorite_params, as: :json

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:error]).to eq("Country can't be blank")
        expect(parsed_response[:status]).to eq(400)
      end
    end
  end
end


# favorite_hash = JSON.parse(response.body, symbolize_names: true)

#         expect(favorite_hash).to be_a(Hash)
#         expect(favorite_hash).to have_key(:data)

#         favorite = favorite_hash[:data]

#         expect(favorite).to be_a(Hash)

#         expect(favorite).to have_key(:id)
#         expect(favorite[:id]).to be_a(String)

#         expect(favorite).to have_key(:type)
#         expect(favorite[:type]).to eq("favorite")

#         expect(favorite).to have_key(:attributes)
#         expect(favorite[:attributes]).to be_a(Hash)

#         favorite_info = favorite[:attributes]

#         expect(favorite_info).to have_key(:name)
#         expect(favorite_info[:name]).to be_a(String)
#         expect(favorite_info[:name]).to eq("Odell")

#         expect(favorite_info).to have_key(:email)
#         expect(favorite_info[:email]).to be_a(String)
#         expect(favorite_info[:email]).to eq("goodboy@ruffruff.com")

#         expect(favorite_info).to have_key(:api_key)
#         expect(favorite_info[:api_key]).to be_a(String)

#         expect(favorite_info).to_not have_key(:password)
#         expect(favorite_info).to_not have_key(:password_digest)
#         expect(favorite_info).to_not have_key(:password_confirmation)