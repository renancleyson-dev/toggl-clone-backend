# frozen_string_literal: true

# CRUD operations on user model controller.
class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = params[:user][:username]

    if @user.save
      flash[:notice] = 'User has been successfully created'
      redirect_to '/login'
    else
      flash.now[:alert] = ''
      render :new
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
    if session[:user_id]
      flash[:alert] = 'You are already logged in!'
      redirect_to '/app/dashboard'
    else
      render :login
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
