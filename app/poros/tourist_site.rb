class TouristSite
  attr_reader :id,
              :name,
              :address,
              :place_id
  
  def initialize(site_info)
    @id = nil
    @name = site_info[:name]
    @address = site_info[:formatted]
    @place_id = site_info[:place_id]
  end
end