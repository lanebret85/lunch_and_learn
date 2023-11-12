class Recipe
  attr_reader :id,
              :title,
              :url,
              :image
  attr_accessor :country

  def initialize(recipe_info)
    @id = nil
    @title = recipe_info[:label]
    @url = recipe_info[:url]
    @country = ""
    @image = recipe_info[:image]
  end
end