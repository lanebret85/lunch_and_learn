class Api::V1::UserFavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      render json: FavoriteSerializer.new(user.favorites)
    else
      render json: { error: "User not found with given API key", status: 404 }, status: 404
    end
  end
end