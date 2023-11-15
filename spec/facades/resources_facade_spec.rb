require "rails_helper"

RSpec.describe ResourcesFacade do
  describe "#get_photos" do
    describe "If the get_photos method in the photos service returns data that is not nil" do
      it "returns an array of Photo objects" do
        VCR.use_cassette("#get_photos_facade_happy") do
          photos = ResourcesFacade.new.get_photos('thailand')

          expect(photos).to be_an(Array)
          expect(photos.first).to be_a(Photo)
          expect(photos.last).to be_a(Photo)
        end
      end
    end

    describe "If the get_photos method in the photos service returns data that is nil" do
      it "returns an empty array" do
        VCR.use_cassette("#get_photos_facade_sad") do
          photos = ResourcesFacade.new.get_photos('starfightermegaplexunicorn')
          
          expect(photos).to be_an(Array)
          expect(photos).to be_empty
        end
      end
    end
  end

  describe "#get_video" do
    describe "If the get_video method in the videos service returns data that is not nil" do
      it "returns a Video object" do
        VCR.use_cassette("#get_video_facade_happy") do
          video = ResourcesFacade.new.get_video('thailand')

          expect(video).to be_a(Video)
        end
      end
    end

    describe "If the get_video method in the videos service returns data that is  nil" do
      it "returns an empty hash" do
        VCR.use_cassette("#get_video_facade_sad") do
          video = ResourcesFacade.new.get_video('starfightermegaplexunicorn')

          expect(video).to be_a(Hash)
          expect(video).to be_empty
        end
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