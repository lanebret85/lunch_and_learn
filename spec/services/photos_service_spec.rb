require "rails_helper"

RSpec.describe PhotosService do
  describe "#get_photos" do
    it "returns data for an array of photos related to the query argument" do
      VCR.use_cassette("#get_photos_service") do
        photos = PhotosService.new.get_photos('thailand')

        expect(photos).to be_an(Array)
        expect(photos.first).to be_a(Hash)
        expect(photos.first).to have_key(:alt_description)
        expect(photos.first[:alt_description]).to be_a(String)
        expect(photos.first).to have_key(:urls)
        expect(photos.first[:urls]).to be_a(Hash)
        expect(photos.first[:urls]).to have_key(:raw)
        expect(photos.first[:urls][:raw]).to be_a(String)
      end
    end
  end
end