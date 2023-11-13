class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      recipes = RecipesFacade.new.get_recipes(params[:country])
      render json: RecipeSerializer.new(recipes)
    else
      country = CountriesFacade.new.get_random_country
      recipes = RecipesFacade.new.get_recipes(country)
      render json: RecipeSerializer.new(recipes)
    end
  end
end