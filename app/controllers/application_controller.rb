# frozen_string_literal: true

# controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::Base
  before_action :request_login_and_set_user

  private

  def request_login_and_set_user
    Session.sweep
    stored_session = Session.where(token: session[:token]).last

    if stored_session.present?
      @user = stored_session.user
    else
      flash[:alert] = 'You must be logged in to access that page'
      redirect_to '/login'
    end
  end
end
