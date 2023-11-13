require "rails_helper"

RSpec.describe VideosService do
  describe "#get_mr_history_video" do
    it "returns data for a video related to the query argument" do
      VCR.use_cassette("#get_mr_history_video") do
        video = VideosService.new.get_mr_history_video('thailand')

        expect(video).to be_a(Hash)
        expect(video).to have_key(:snippet)
        expect(video[:snippet]).to be_a(Hash)
        expect(video[:snippet]).to have_key(:title)
        expect(video[:snippet][:title]).to be_a(String)
        expect(video).to have_key(:id)
        expect(video[:id]).to be_a(Hash)
        expect(video[:id]).to have_key(:videoId)
        expect(video[:id][:videoId]).to be_a(String)
      end
    end
  end
end