# frozen_string_literal: true

# CRUD operations to the main source of data of the app
class TimeRecordsController < ApplicationController
  def index
    @time_records = @user.time_records
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(params[:per_page])
  end

  def create
    time_record = TimeRecord.new(time_record_params)
    time_record.save!
  end

  def update
    if !belongs_to_current_user?
      TimeRecord.find(params[:id] || params[:time_record_id]).update(time_record_params)
    else
      head :unauthorized
    end
  end

  def destroy
    if !belongs_to_current_user?
      TimeRecord.delete(params[:id] || params[:time_record_id])
    else
      head :unauthorized
    end
  end

  private

  def time_record_params
    params.require(:time_record).permit(:user_id, :start_time, :end_time, :category, :label)
  end

  def belongs_to_current_user?
    params[:user_id] == @user.id
  end
end
