# frozen_string_literal: true

ActiveAdmin.register Request do
  actions :index, :show, :new, :create, :destroy

  permit_params :name, :surname, :patronymic, :phone_number, :email, :weight, :length, :width, :height,
                :point_of_departure, :destination

  index do
    selectable_column
    column :name
    column :email
    column :point_of_departure
    column :destination
    column :price
    actions
  end

  show do
    attributes_table do
      row :name
      row :surname
      row :patronymic
      row :phone_number, as: Integer
      row :email
      row :weight
      row :length
      row :width
      row :height
      row :point_of_departure
      row :destination
      row :distance
      row :price
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :surname
      f.input :patronymic
      f.input :phone_number
      f.input :email
      f.input :weight
      f.input :length
      f.input :width
      f.input :height
      f.input :point_of_departure
      f.input :destination
    end
    f.actions
  end

  controller do
    def create
      @request = Request.new(permitted_params[:request])
      if @request.valid?
        @request.price = 0
        @request.distance = Geocoder::Calculations.distance_between(Geocoder.coordinates(@request.point_of_departure),
                                                                    Geocoder.coordinates(@request.destination), units: :km).round(2)
        @request.length = @request.length / 100.0
        @request.width = @request.width / 100.0
        @request.height = @request.height / 100.0
        if (@request.length * @request.width * @request.height) < 1
          @request.price += @request.distance
        elsif (@request.length * @request.width * @request.height) > 1
          @request.price += if @request.weight <= 10
                              2 * @request.distance
                            else
                              3 * @request.distance
                            end
        end
        @request.save
        redirect_to admin_request_path(@request.id)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
end
