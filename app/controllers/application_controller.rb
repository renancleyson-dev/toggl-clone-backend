# frozen_string_literal: true

# controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::API
  before_action :login_required

  protected

  def current_user
    auth_header = request.headers['Authorization']

    return nil unless auth_header

    auth_token = auth_header.split(' ')[1]
    decoded_jwt = JsonWebToken.decode(auth_token)

    if !decoded_jwt
      render json: { message: 'Your session expired' },
             status: :unauthorized
    else
      User.find(decoded_jwt['user_id'])
    end
  end

  def login_required
    return if current_user

    render json: { message: 'You must be logged in to access that page' },
           status: :unauthorized
  end
end
