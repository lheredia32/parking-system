# frozen_string_literal: true

require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test 'should get search results when plate number is present' do
    get search_vehicles_url, params: { plate_number: 'ABC123' }
    assert_response :success
    assert_not_nil assigns(:search_results)
  end
  test 'should redirect to index with alert when plate number is not present' do
    get search_vehicles_url
    assert_redirected_to vehicles_path
    assert_equal 'Debes ingresar un número de placa.', flash[:alert]
  end
end
