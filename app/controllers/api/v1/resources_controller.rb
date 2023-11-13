class Api::V1::ResourcesController < ApplicationController
  def index
    resource = ResourcesFacade.new.get_resource(params[:country])
    render json: LearningResourceSerializer.new(resource)
  end
end