# frozen_string_literal: true

# CRUD operations on user model controller.
class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[create login]

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  def update
    current_user.update(user_params)
  end

  def destroy
    current_user.destroy
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      @token = JsonWebToken.encode({ user_id: @user.id })
      render :login
    else
      render json: { message: "Email or password don't match" },
             status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email).merge({ password: params[:password] })
  end
end
