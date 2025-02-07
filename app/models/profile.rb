# frozen_string_literal: true

# ...
class Profile < ApplicationRecord
  belongs_to :user

  validates :name, :last_name, :phone_number, presence: true
end
