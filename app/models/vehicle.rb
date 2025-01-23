# frozen_string_literal: true

# ...
class Vehicle < ApplicationRecord
  enum :vehicle_type, { Motocicleta: 0, Carro: 1, Bicicleta: 2 }

  def total_time
    return '-' unless exit_time

    seconds_diff = (exit_time - entry_time).to_i

    hours = seconds_diff / 3600
    minutes = (seconds_diff % 3600) / 60

    "#{hours}h #{minutes}m"
  end

  def total_time_in_hours
    return 0 unless exit_time

    ((exit_time - entry_time) / 1.hour.to_f).ceil
  end

  def total_cost
    return 0 if total_time_in_minutes <= 30

    calculate_cost
  end

  private

  def calculate_cost
    case vehicle_type
    when 'Motocicleta'
      total_time_in_hours * 3500
    when 'Carro'
      total_time_in_hours * 5000
    when 'Bicicleta'
      total_time_in_hours.positive? ? 2500 : 0
    else
      0
    end
  end

  def total_time_in_minutes
    return 0 unless exit_time

    ((exit_time - entry_time) / 1.minute).round
  end
end
