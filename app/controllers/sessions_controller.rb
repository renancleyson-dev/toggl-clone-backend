# frozen_string_literal: true

# save a token on session hash and set to nil on logout
class SessionsController < ApplicationController
  skip_before_action :request_login_and_set_user, only: :create

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      new_user_session(@user)
      redirect_to ENV['FRONTEND_ADDRESS']
    else
      flash[:alert] = "Username or password don't match"
      redirect_to '/'
    end
  end

  def destroy
    Session.destroy(params[:id])
    redirect_to '/'
  end

  private

  def new_user_session(user)
    @user_session = Session.create(user: user)
    session[:token] = @user_session.token
    cookies[:user_id] = user.id
  end
end
