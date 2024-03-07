# frozen_string_literal: true

class RequestsController < InheritedResources::Base
  private

  def request_params
    params.require(:request).permit(:weight, :length, :width, :height, :distance, :price, :point_of_departure,
                                    :destination, :name, :surname, :patronymic, :phone_number, :email)
  end
end
