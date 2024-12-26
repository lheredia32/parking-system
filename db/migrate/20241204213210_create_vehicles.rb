# frozen_string_literal: true

# Esta migración crea la tabla 'vehicles' con las columnas 'plate_number', 'entry_time' y 'exit_time'.
class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate_number
      t.datetime :entry_time
      t.datetime :exit_time

      t.timestamps
    end
  end
end
