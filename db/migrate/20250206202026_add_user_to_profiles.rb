# frozen_string_literal: true

# ...
class AddUserToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_reference :profiles, :user, foreign_key: true
  end
end
