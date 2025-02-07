# frozen_string_literal: true

# ...
class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
