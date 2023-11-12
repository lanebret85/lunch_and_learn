class RecipesFacade
  def get_recipes(query)
    recipes = RecipesService.new.get_recipes(query)[:hits]
    objects_array = recipes.map do |recipe|
      recipe = Recipe.new(recipe[:recipe])
    end
    objects_array.each do |recipe|
      recipe.country = query
    end
    objects_array
  end
end