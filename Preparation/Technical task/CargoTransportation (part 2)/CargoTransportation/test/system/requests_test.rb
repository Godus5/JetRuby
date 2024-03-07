require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  setup do
    @request = requests(:one)
  end

  test "visiting the index" do
    visit requests_url
    assert_selector "h1", text: "Requests"
  end

  test "should create request" do
    visit requests_url
    click_on "New request"

    fill_in "Destination", with: @request.destination
    fill_in "Distance", with: @request.distance
    fill_in "Email", with: @request.email
    fill_in "Height", with: @request.height
    fill_in "Length", with: @request.length
    fill_in "Name", with: @request.name
    fill_in "Patronymic", with: @request.patronymic
    fill_in "Phone number", with: @request.phone_number
    fill_in "Point of departure", with: @request.point_of_departure
    fill_in "Price", with: @request.price
    fill_in "Surname", with: @request.surname
    fill_in "Weight", with: @request.weight
    fill_in "Width", with: @request.width
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "should update Request" do
    visit request_url(@request)
    click_on "Edit this request", match: :first

    fill_in "Destination", with: @request.destination
    fill_in "Distance", with: @request.distance
    fill_in "Email", with: @request.email
    fill_in "Height", with: @request.height
    fill_in "Length", with: @request.length
    fill_in "Name", with: @request.name
    fill_in "Patronymic", with: @request.patronymic
    fill_in "Phone number", with: @request.phone_number
    fill_in "Point of departure", with: @request.point_of_departure
    fill_in "Price", with: @request.price
    fill_in "Surname", with: @request.surname
    fill_in "Weight", with: @request.weight
    fill_in "Width", with: @request.width
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "should destroy Request" do
    visit request_url(@request)
    click_on "Destroy this request", match: :first

    assert_text "Request was successfully destroyed"
  end
end
