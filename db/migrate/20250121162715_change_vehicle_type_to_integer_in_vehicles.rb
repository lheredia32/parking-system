# frozen_string_literal: true

class ChangeVehicleTypeToIntegerInVehicles < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    remove_column :vehicles, :vehicle_type, :string
    add_column :vehicles, :vehicle_type, :integer, default: 0
  end
end
