class Api::V1::TourismController < ApplicationController
  def index
    tourist_sites = TourismFacade.new.get_tourist_sites(params[:country])
    render json: TouristSiteSerializer.new(tourist_sites)
  end
end