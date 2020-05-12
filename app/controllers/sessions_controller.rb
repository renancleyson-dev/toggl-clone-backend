# frozen_string_literal: true

# Save the id of user in session hash and set to nil on logout
class SessionsController < ApplicationController
  protect_from_forgery with: :reset_session
  skip_before_action :require_login, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      @session = Session.create(user: user)
      session[:token] = @session.token
      redirect_to '/app/dashboard'
    else
      flash[:alert] = user.nil? ? "The username doesn't exist" : 'Wrong password!'
      redirect_to '/login'
    end
  end

  def destroy
    Session.destroy(params[:id])
    redirect_to '/login'
  end
end
