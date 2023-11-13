require "rails_helper"

RSpec.describe Resource do
  describe "existance" do
    it "exists and has readable attributes" do
      video = Video.new(
        {
          snippet: {
            title: "charlie bit me"
          },
          id: {
            videoId: "123456789"
          }
        }
      )
      photo_1 = Photo.new(
        {
          alt_description: "pretty picture",
          urls: {
            raw: "www.pretty_picture.com"
          }
        }
      )
      photo_2 = Photo.new(
        {
          alt_description: "cool picture",
          urls: {
            raw: "www.cool_picture.com"
          }
        }
      )
      photo_3 = Photo.new(
        {
          alt_description: "neat picture",
          urls: {
            raw: "www.neat_picture.com"
          }
        }
      )
      photos = [photo_1, photo_2, photo_3]
      resource = Resource.new(video, photos, "thailand")

      expect(resource).to be_a(Resource)
      expect(resource.id).to be(nil)
      expect(resource.video).to eq(video)
      expect(resource.images).to eq(photos)
      expect(resource.country).to eq("thailand")
    end
  end
end