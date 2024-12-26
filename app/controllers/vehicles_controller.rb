# frozen_string_literal: true

# ...
class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.entry_time = Time.current

    if @vehicle.save
      redirect_to root_path, notice: 'Vehículo registrado con éxito.'
    else
      redirect_to root_path, alert: 'Error al registrar el vehículo.'
    end
  end

  def exit
    @vehicle = Vehicle.find(params[:id])
    @vehicle.update(exit_time: Time.current)

    redirect_to root_path, notice: "Salida registrada para el vehículo #{@vehicle.plate_number}."
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate_number)
  end
end
