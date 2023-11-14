require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }
  end

  describe "relationships" do
    it { should have_many :favorites }
  end

  describe "password security" do
    it { should have_secure_password }
  end

  describe "#generate_api_key" do
    it "can generate a random string of 32 characters as a new api key" do
      user = User.create!(name: "Lane", email: "lane@example.com", password_digest: "laneiscool", api_key: "a")

      query = user.generate_api_key

      expect(query).to be_a(String)
      expect(query.length).to eq(32)
    end
  end
end