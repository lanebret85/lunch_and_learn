require "rails_helper"

RSpec.describe Photo do
  describe "existance" do
    it "exists and has readable attributes" do
      photo = Photo.new(
        {
          alt_description: "pretty picture",
          urls: {
            raw: "www.pretty_picture.com"
          }
        }
      )

      expect(photo).to be_a(Photo)
      expect(photo.alt_tag).to eq("pretty picture")
      expect(photo.url).to eq("www.pretty_picture.com")
    end
  end
end