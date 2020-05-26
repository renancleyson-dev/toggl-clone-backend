# frozen_string_literal: true

# CRUD operations to the main source of data of the app
class TimeRecordsController < ApplicationController
  def index
    @time_records = @user.time_records
  end

  def create
    time_record = TimeRecord.new(time_record_params)
    time_record.user_id = params[:user_id]
    time_record.save!
  end

  def update
    TimeRecord.find(params[:id]).update(time_record_params)
  end

  def destroy
    TimeRecord.delete(params[:id]) if params[:user_id] == @user.id
  end

  private

  def time_record_params
    params.require(:time_record).permit(:start_time, :end_time)
  end
end
