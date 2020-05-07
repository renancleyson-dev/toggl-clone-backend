# frozen_string_literal: true

# Save the id of user in session hash and set to nil on logout
class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/app/dashboard'
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
