require "rails_helper"

RSpec.describe "Learning Resources Index" do
  describe "When the backend receives a request for an educational resource associated with a country paramter" do
    it "makes a request to the Youtube API and receives video data associated to the country as a response, and it makes a request to the Unsplash API and receives photo data associated to the country as a response, and then it sends a response to the frontend with the data it received from Youtube and Unsplash" do
      VCR.use_cassette("thailand resources") do
        get "/api/v1/learning_resources", params: { country: 'thailand' }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        resources_hash = JSON.parse(response.body, symbolize_names: true)

        expect(resources_hash).to be_a(Hash)
        expect(resources_hash).to have_key(:data)

        resource = resources_hash[:data]

        expect(resource).to be_a(Hash)

        expect(resource).to have_key(:id)
        expect(resource[:id]).to eq(nil)

        expect(resource).to have_key(:type)
        expect(resource[:type]).to eq("learning_resource")

        expect(resource).to have_key(:attributes)
        expect(resource[:attributes]).to be_a(Hash)

        resource_info = resource[:attributes]

        expect(resource_info).to have_key(:country)
        expect(resource_info[:country]).to be_a(String)
        expect(resource_info[:country]).to eq("thailand")

        expect(resource_info).to have_key(:video)
        expect(resource_info[:video]).to be_a(Hash)

        resource_video = resource_info[:video]

        expect(resource_video).to have_key(:title)
        expect(resource_video[:title]).to be_a(String)
        
        expect(resource_video).to have_key(:youtube_video_id)
        expect(resource_video[:youtube_video_id]).to be_a(String)

        expect(resource_info).to have_key(:images)
        expect(resource_info[:images]).to be_an(Array)

        resource_image_1 = resource_info[:images].first

        expect(resource_image_1).to have_key(:alt_tag)
        expect(resource_image_1[:alt_tag]).to be_a(String)
        
        expect(resource_image_1).to have_key(:url)
        expect(resource_image_1[:url]).to be_a(String)

        expect(resource_info).to_not have_key(:kind)
        expect(resource_info).to_not have_key(:nextPageToken)
        expect(resource_info).to_not have_key(:regionCode)
        expect(resource_info).to_not have_key(:pageInfo)
        expect(resource_info).to_not have_key(:channelId)
        expect(resource_info).to_not have_key(:description)
        expect(resource_info).to_not have_key(:thumbnails)
        expect(resource_info).to_not have_key(:items)
        expect(resource_info).to_not have_key(:publishedAt)
        expect(resource_info).to_not have_key(:channelTitle)
        expect(resource_info).to_not have_key(:liveBroadcastContent)
        expect(resource_info).to_not have_key(:publishTime)
        expect(resource_info).to_not have_key(:total)
        expect(resource_info).to_not have_key(:total_pages)
        expect(resource_info).to_not have_key(:results)
        expect(resource_info).to_not have_key(:slug)
        expect(resource_info).to_not have_key(:width)
        expect(resource_info).to_not have_key(:height)
        expect(resource_info).to_not have_key(:color)
        expect(resource_info).to_not have_key(:blur_hash)
        expect(resource_info).to_not have_key(:breadcrumbs)
        expect(resource_info).to_not have_key(:likes)
        expect(resource_info).to_not have_key(:liked_by_user)
        expect(resource_info).to_not have_key(:user)
      end
    end
  end

  describe "When the backend receives a request for an educational resource with a country parameter that doesn't return results" do
    it "sends a response to the frontend with empty attributes for the video and images keys" do
      VCR.use_cassette("starfightermegaplexunicorn resources") do
        get "/api/v1/learning_resources", params: { country: 'starfightermegaplexunicorn' }

        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        resources_hash = JSON.parse(response.body, symbolize_names: true)

        expect(resources_hash).to be_a(Hash)
        expect(resources_hash).to have_key(:data)

        resource = resources_hash[:data]

        expect(resource).to be_a(Hash)

        expect(resource).to have_key(:id)
        expect(resource[:id]).to eq(nil)

        expect(resource).to have_key(:type)
        expect(resource[:type]).to eq("learning_resource")

        expect(resource).to have_key(:attributes)
        expect(resource[:attributes]).to be_a(Hash)

        resource_info = resource[:attributes]

        expect(resource_info).to have_key(:country)
        expect(resource_info[:country]).to be_a(String)
        expect(resource_info[:country]).to eq("starfightermegaplexunicorn")

        expect(resource_info).to have_key(:video)
        expect(resource_info[:video]).to be_a(Hash)
        expect(resource_info[:video]).to be_empty

        expect(resource_info).to have_key(:images)
        expect(resource_info[:images]).to be_an(Array)
        expect(resource_info[:images]).to be_empty
      end
    end
  end
end