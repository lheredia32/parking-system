# frozen_string_literal: true

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# frozen_string_literal: true

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    @vehicle = Vehicle.new(entry_time: Time.now)
  end

  test 'total_time returns "-" if exit_time is nil' do
    assert_equal '-', @vehicle.total_time
  end

  test 'total_time returns correct time difference in hours and minutes' do
    @vehicle.exit_time = @vehicle.entry_time + 2.hours + 30.minutes
    assert_equal '2h 30m', @vehicle.total_time
  end

  test 'total_time returns correct time difference when less than an hour' do
    @vehicle.exit_time = @vehicle.entry_time + 45.minutes
    assert_equal '0h 45m', @vehicle.total_time
  end

  test 'total_time returns correct time difference when more than a day' do
    @vehicle.exit_time = @vehicle.entry_time + 1.day + 3.hours + 15.minutes
    assert_equal '27h 15m', @vehicle.total_time
  end
end
