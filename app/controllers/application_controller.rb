# frozen_string_literal: true

# controller class with all methods and callbacks for every controller on app
class ApplicationController < ActionController::API
  before_action :login_required

  private

  def login_required
    render json: { message: 'You must be logged in to access that page' },
           status: :unauthorized
  end
end
