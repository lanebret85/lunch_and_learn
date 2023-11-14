class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: favorite_params[:api_key])
    if user
      favorite = user.favorites.new(country: favorite_params[:country], recipe_link: favorite_params[:recipe_link], recipe_title: favorite_params[:recipe_title])
      if favorite.save
        render json: { success: "Favorite added successfully", status: 201 }, status: 201
      else
        render json: { error: favorite.errors.full_messages.to_sentence, status: 400 }, status: 400
      end
    else
      render json: { error: "User not found with given API key", status: 404 }, status: 404
    end
  end

  private

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end