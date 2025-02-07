# frozen_string_literal: true

# ...
class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :profile, foreign_key: true unless column_exists?(:users, :profile_id)
  end
end
