# frozen_string_literal: true

# CRUD operations to the main source of data of the app
class TimeRecordsController < ApplicationController
  def index
    time_records = current_user.time_records
                               .order(start_time: :desc)
                               .page(params[:page])
                               .per(params[:per_page])

    @time_records_grouped = TimeRecord.group_by_date(time_records)
  end

  def create
    @time_record = TimeRecord.new(time_record_params)

    authorize @time_record
    if @time_record.save
      render :show, status: :created
    else
      render json: @time_record.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    @time_record = TimeRecord.find(params[:id])

    authorize @time_record
    @time_record.update(time_record_params)
  end

  def destroy
    @time_record = TimeRecord.find(params[:id])

    authorize @time_record
    @time_record.destroy
  end

  private

  def time_record_params
    params.require(:time_record).permit(:user_id, :project_id, :start_time,
                                        :end_time, :category, :label)
  end
end
