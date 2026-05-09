# frozen_string_literal: true

# ...
class User < ApplicationRecord
  attribute :role, :integer, default: 0
  enum :role, { empleado: 0, admin: 1 }, default: :empleado

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :vehicles, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def admin?
    role == 'admin'
  end
end
