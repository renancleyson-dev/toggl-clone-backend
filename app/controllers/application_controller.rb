# frozen_string_literal: true

# Controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    Session.sweep('20 minutes')
    return if Session.find_by(token: session[:token])

    flash[:alert] = 'You must be logged in to access that page'
    redirect_to '/login'
  end
end
