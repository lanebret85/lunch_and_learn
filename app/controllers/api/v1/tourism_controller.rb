class Api::V1::TourismController < ApplicationController
  def index
    begin
      tourist_sites = TourismFacade.new.get_tourist_sites(params[:country])
      if tourist_sites.empty?
        render json: {
          status: 404,
          error: "Tourist sites not found"
        }
      else
        render json: TouristSiteSerializer.new(tourist_sites)
      end
    rescue => e
      render json: {
        status: 404,
        error: "Invalid country name"
      }
    end
  end
end