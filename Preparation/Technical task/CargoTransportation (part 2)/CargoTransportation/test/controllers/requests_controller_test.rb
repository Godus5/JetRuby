# frozen_string_literal: true

require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request = requests(:one)
  end

  test 'should get index' do
    get requests_url
    assert_response :success
  end

  test 'should get new' do
    get new_request_url
    assert_response :success
  end

  test 'should create request' do
    assert_difference('Request.count') do
      post requests_url,
           params: { request: { destination: @request.destination, distance: @request.distance, email: @request.email,
                                height: @request.height, length: @request.length, name: @request.name, patronymic: @request.patronymic, phone_number: @request.phone_number, point_of_departure: @request.point_of_departure, price: @request.price, surname: @request.surname, weight: @request.weight, width: @request.width } }
    end

    assert_redirected_to request_url(Request.last)
  end

  test 'should show request' do
    get request_url(@request)
    assert_response :success
  end

  test 'should get edit' do
    get edit_request_url(@request)
    assert_response :success
  end

  test 'should update request' do
    patch request_url(@request),
          params: { request: { destination: @request.destination, distance: @request.distance, email: @request.email,
                               height: @request.height, length: @request.length, name: @request.name, patronymic: @request.patronymic, phone_number: @request.phone_number, point_of_departure: @request.point_of_departure, price: @request.price, surname: @request.surname, weight: @request.weight, width: @request.width } }
    assert_redirected_to request_url(@request)
  end

  test 'should destroy request' do
    assert_difference('Request.count', -1) do
      delete request_url(@request)
    end

    assert_redirected_to requests_url
  end
end
