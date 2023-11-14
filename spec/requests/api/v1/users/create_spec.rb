require "rails_helper"

RSpec.describe "Users Create" do
  describe "When the backend receives a POST request for a user with a hash of user information - including name, email, password, and password confirmation - in the request body" do
    it "confirms that all required informtion has been sent, that the password and password_confirmation match, and that the email does not already exist. If all necessary information is validated, it generates a 32-character api key for the user and creates a user record in the database. Finally, it sends a response to the frontend with information about the newly created user, including their id, name, email, and api_key" do
      VCR.use_cassette("user create") do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }

        post "/api/v1/users", params: user_params, as: :json

        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        user_hash = JSON.parse(response.body, symbolize_names: true)

        expect(user_hash).to be_a(Hash)
        expect(user_hash).to have_key(:data)

        user = user_hash[:data]

        expect(user).to be_a(Hash)

        expect(user).to have_key(:id)
        expect(user[:id]).to be_a(String)

        expect(user).to have_key(:type)
        expect(user[:type]).to eq("user")

        expect(user).to have_key(:attributes)
        expect(user[:attributes]).to be_a(Hash)

        user_info = user[:attributes]

        expect(user_info).to have_key(:name)
        expect(user_info[:name]).to be_a(String)
        expect(user_info[:name]).to eq("Odell")

        expect(user_info).to have_key(:email)
        expect(user_info[:email]).to be_a(String)
        expect(user_info[:email]).to eq("goodboy@ruffruff.com")

        expect(user_info).to have_key(:api_key)
        expect(user_info[:api_key]).to be_a(String)

        expect(user_info).to_not have_key(:password)
        expect(user_info).to_not have_key(:password_digest)
        expect(user_info).to_not have_key(:password_confirmation)
      end
    end
  end

  describe "When the backend receives a POST request for a user with a hash of user information - including name, email, password, and password confirmation - in the request body, but the password and password confirmation don't match" do
    it "sends a response to the frontend with a 400 status code and an error message that passwords must match" do
      VCR.use_cassette("passwords dont match") do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "dogiscool"
        }

        post "/api/v1/users", params: user_params, as: :json

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:error]).to eq("Passwords must match")
        expect(parsed_response[:status]).to eq(400)
      end
    end
  end

  describe "When the backend receives a POST request for a user with a hash of user information - including name, password, and password confirmation, but not email - in the request body" do
    it "sends a response to the frontend with a 400 status code and an error message that email can't be blank" do
      VCR.use_cassette("passwords dont match") do
        user_params = {
          "name": "Odell",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }

        post "/api/v1/users", params: user_params, as: :json

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:error]).to eq("Email can't be blank")
        expect(parsed_response[:status]).to eq(400)
      end
    end
  end
end