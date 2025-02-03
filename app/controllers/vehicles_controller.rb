# frozen_string_literal: true

class VehiclesController < ApplicationController
  before_action :set_common_variables, only: %i[index search]

  def index; end

  def search
    @search_results = if params[:plate_number].present?
                        Vehicle.where('plate_number LIKE ?', "%#{params[:plate_number]}%")
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

    if @vehicle.save
      redirect_to root_path, notice: 'Vehículo registrado con éxito.'
    else
      flash[:alert] = @vehicle.errors.full_messages.to_sentence
      render :new
    end
  end

  def exit
    @vehicle = Vehicle.find_by(id: params[:id])

    redirect_to root_path, alert: 'Vehículo no encontrado.' and return if @vehicle.nil?

    if @vehicle.update(exit_time: Time.current)
      redirect_to root_path, notice: "Salida registrada para el vehículo #{@vehicle.plate_number}."
    else
      redirect_to root_path, alert: 'Error al registrar la salida del vehículo.'
    end
  end

  def all_records
    @vehicles = if params[:search].present?
                  Vehicle.where('plate_number LIKE ? OR vehicle_type LIKE ?',
                                "%#{params[:search]}%", "%#{params[:search]}%")
                         .order(created_at: :desc)
                else
                  Vehicle.all.order(created_at: :desc)
                end
  end

  private

  def set_common_variables
    @vehicles_in_parking = Vehicle.where(exit_time: nil)
    @recent_exits = Vehicle.where.not(exit_time: nil).order(exit_time: :desc).limit(5)
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate_number, :vehicle_type)
  end
end
