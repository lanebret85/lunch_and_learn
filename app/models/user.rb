class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :api_key, presence: true, uniqueness: true

  has_many :favorites

  has_secure_password

  def generate_api_key
    numbers_letters_array = [*'0'..'9', *'a'..'z', *'A'..'Z']
    new_api_key = ""
    32.times do
      new_api_key << numbers_letters_array.sample
    end
    new_api_key
  end
end