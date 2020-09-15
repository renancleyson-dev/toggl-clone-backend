# frozen_string_literal: true

# controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::API
  before_action :login_required

  private

  def auth_token
    auth_header = request.headers['Authorization']
    auth_header.split(' ')[1]
  end

  def login_required
    user_id = JsonWebToken.decode(auth_token)['user_id']
    @user = User.find(user_id)

    return if @user.present?

    render json: { message: 'You must be logged in to access that page' },
           status: :unauthorized
  end
end
