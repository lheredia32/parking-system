# frozen_string_literal: true

# ...
class Vehicle < ApplicationRecord
  def total_time
    return '-' unless exit_time

    seconds_diff = (exit_time - entry_time).to_i

    hours = seconds_diff / 3600
    minutes = (seconds_diff % 3600) / 60

    "#{hours}h #{minutes}m"
  end
end
