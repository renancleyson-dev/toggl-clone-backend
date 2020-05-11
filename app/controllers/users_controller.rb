# frozen_string_literal: true

# CRUD operations on user model controller.
class UsersController < ApplicationController
  protect_from_forgery with: :reset_session
  skip_before_action :require_login, except: %i[show edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User has been successfully created'
      redirect_to '/login'
    else
      @user.errors_by_field.each { |field, msg| flash[field] = msg }
      redirect_to '/sign_up'
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def edit; end

  def update
    User.find(params[:id]).update(user_params)
  end

  def destroy
    User.delete(params[:id])
  end

  def login
    if session[:token]
      flash[:alert] = 'You are already logged in!'
      redirect_to '/app/dashboard'
    else
      render :login
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :full_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
