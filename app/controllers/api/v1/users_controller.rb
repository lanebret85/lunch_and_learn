class Api::V1::UsersController < ApplicationController
  def create
    if user_params[:password] == user_params[:password_confirmation]
      user = User.new(user_params)
      user.update(api_key: user.generate_api_key)
      if user.save
        render json: UserSerializer.new(user), status: 201
      else
        render json: { error: user.errors.full_messages.to_sentence, status: 400 }, status: 400
      end
    else
      render json: { error: "Passwords must match", status: 400 }, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end