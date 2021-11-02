# frozen_string_literal: true

# CRUD operations to the main source of data of the app
class TimeRecordsController < ApplicationController
  before_action :set_time_record, only: %i[update destroy]

  def index
    time_records = current_user.time_records
                               .order(start_time: :desc)
                               .page(params[:page])
                               .per(params[:per_page])

    @time_records_grouped = TimeRecord.group_by_date(time_records)
  end

  def create
    @time_record = TimeRecord.new(time_record_params)

    if @time_record.save
      render :show, status: :created
    else
      render json: @time_record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @time_record.update(time_record_params)
      render :show, status: :ok, location: @time_record
    else
      render json: @time_record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @time_record.destroy
  end

  private

  def set_time_record
    @time_record = current_user.time_records.find(params[:id])
  end

  def time_record_params
    params.permit(
      :project_id, :start_time, :end_time, :category, :label, tag_ids: []
    ).merge({ user_id: current_user.id })
  end
end
