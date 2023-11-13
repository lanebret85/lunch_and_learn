require "rails_helper"

RSpec.describe Video do
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

      expect(video).to be_a(Video)
      expect(video.title).to eq("charlie bit me")
      expect(video.youtube_video_id).to eq("123456789")
    end
  end
end