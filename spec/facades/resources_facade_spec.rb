require "rails_helper"

RSpec.describe ResourcesFacade do
  describe "#get_photos" do
    it "returns an array of Photo objects" do
      VCR.use_cassette("#get_photos_facade") do
        photos = ResourcesFacade.new.get_photos('thailand')

        expect(photos).to be_an(Array)
        expect(photos.first).to be_a(Photo)
        expect(photos.last).to be_a(Photo)
      end
    end
  end

  describe "#get_video" do
    it "returns a Video object" do
      VCR.use_cassette("#get_video_facade") do
        video = ResourcesFacade.new.get_video('thailand')

        expect(video).to be_an(Video)
      end
    end
  end

  describe "#get_resource" do
    it "returns a Resource object" do
      VCR.use_cassette("#get_resource_facade") do
        resource = ResourcesFacade.new.get_resource('thailand')

        expect(resource).to be_a(Resource)
      end
    end
  end
end