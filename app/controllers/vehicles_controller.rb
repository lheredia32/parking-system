# frozen_string_literal: true

# ...
class VehiclesController < ApplicationController
  before_action :set_common_variables, only: %i[index search]

  def index
    @vehicles = if Current.user
                  Current.user.vehicles.order(created_at: :desc)
                else
                  []
                end
  end

  def search
    @search_results = if params[:plate_number].present?
                        Current.user.vehicles.where('plate_number LIKE ?', "%#{params[:plate_number]}%").limit(10)
                      else
                        []
                      end

    respond_to do |format|
      format.html do
        render partial: 'vehicles/search_results_frame', locals: { search_results: @search_results }
      end
    end
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.entry_time = Time.current
    @vehicle.user = Current.user

    if @vehicle.save
      redirect_to root_path
    else
      flash[:alert] = @vehicle.errors.full_messages.to_sentence
      render :new
    end
  end

  def exit
    @vehicle = Current.user.vehicles.find_by(id: params[:id])

    redirect_to root_path and return if @vehicle.nil?

    if @vehicle.update(exit_time: Time.current)
      redirect_to root_path, notice: "Salida registrada para el vehículo #{@vehicle.plate_number}."
    else
      redirect_to root_path, alert: 'Error al registrar la salida del vehículo.'
    end
  rescue ActiveRecord::StatementInvalid => e
    flash[:alert] = "Error al actualizar: #{e.message}"
  end

  def records_by_user
    @vehicles = if params[:search].present?
                  Current.user.vehicles.where('plate_number LIKE ? OR vehicle_type LIKE ?',
                                              "%#{params[:search]}%", "%#{params[:search]}%")
                         .order(created_at: :desc)
                else
                  Current.user.vehicles.order(created_at: :desc)
                end
  end

  private

  def set_common_variables
    p 'Current.user: ', Current.user
    puts '.......................................................'
    @vehicles_in_parking = Current.user.vehicles.where(exit_time: nil)
    @recent_exits = Current.user.vehicles.where.not(exit_time: nil).order(exit_time: :desc).limit(5)
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate_number, :vehicle_type)
    # params.expect(vehicle: %i[plate_number vehicle_type])
  end
end
