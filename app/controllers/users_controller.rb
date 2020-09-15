# frozen_string_literal: true

# CRUD operations on user model controller.
class UsersController < ApplicationController
  skip_before_action :login_required, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :ok
    else
      render json: @user.errors.messages, status: :unprocessable_entity
    end
  end

  def show; end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
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
