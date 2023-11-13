class RecipesFacade
  def get_recipes(query)
    recipes = RecipesService.new.get_recipes(query)[:hits]
    recipes.map do |recipe|
      Recipe.new(recipe[:recipe], query)
    end
  end
end