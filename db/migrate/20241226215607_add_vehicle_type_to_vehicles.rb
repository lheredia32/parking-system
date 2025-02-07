# frozen_string_literal: true

# ...
class AddVehicleTypeToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_column :vehicles, :vehicle_type, :string
  end
end
