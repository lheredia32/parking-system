# frozen_string_literal: true

# ...
class AddUserToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_reference :vehicles, :user, foreign_key: true
  end
end
