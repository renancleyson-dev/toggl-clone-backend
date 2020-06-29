# frozen_string_literal: true

# CRUD operations to the main source of data of the app
class TimeRecordsController < ApplicationController
  # should skip just in development because the frontend doesn't is integrated with the backend
  skip_forgery_protection

  def index
    @time_records = @user
                    .time_records
                    .order(created_at: :desc)
                    .page(params[:page])
                    .per(params[:per_page])
  end

  def create
    time_record = TimeRecord.new(time_record_params)
    time_record.user_id = @user.id
    time_record.save!
  end

  def update
    return if params[:user_id].to_i != @user.id

    TimeRecord.find(params[:id]).update(time_record_params)
  end

  def destroy
    TimeRecord.delete(params[:id]) if params[:user_id] == @user.id
  end

  private

  def time_record_params
    params.require(:time_record).permit(:start_time, :end_time, :category, :label)
  end
end
