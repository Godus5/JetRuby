ActiveAdmin.register Request do
  index do
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
      row :phone_number
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

  controller do

    def new
      @request = Request.new
    end
    
    def create
      @request = Request.new
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
      if @request.save
        redirect_to @request
      else
        render :new, status: :unprocessable_entity    
      end
    end
  end

  actions :index, :show, :new, :create, :destroy

permit_params :name, :surname, :patronymic, :phone_number, :email, :weight, :length, :width, :height, :point_of_departure, :destination
    
end
