# frozen_string_literal: true

# ...
class AddDetailsToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :last_name, :string
    add_column :profiles, :phone_number, :string
  end
end
