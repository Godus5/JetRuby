json.extract! request, :id, :weight, :length, :width, :height, :distance, :price, :point_of_departure, :destination, :name, :surname, :patronymic, :phone_number, :email, :created_at, :updated_at
json.url request_url(request, format: :json)
