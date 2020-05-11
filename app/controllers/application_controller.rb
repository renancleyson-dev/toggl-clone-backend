# frozen_string_literal: true

# Controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::Base
  before_action :require_login, only: %i[show edit]

  private

  def require_login
    Session.sweep('20 minutes')
    return if Session.find_by(token: session[:token])

    flash[:alert] = 'You must be logged in to access that page'
  end
end
