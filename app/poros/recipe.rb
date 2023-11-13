class Recipe
  attr_reader :id,
              :title,
              :url,
              :image,
              :country

  def initialize(recipe_info, country)
    @id = nil
    @title = recipe_info[:label]
    @url = recipe_info[:url]
    @country = country
    @image = recipe_info[:image]
  end
end