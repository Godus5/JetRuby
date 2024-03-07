# frozen_string_literal: true

class Request < ApplicationRecord
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :length, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :width, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :height, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :surname, presence: true
  validates :patronymic, presence: true
  validates :phone_number, presence: true, length: { is: 11 }
  validates :point_of_departure, presence: true
  validates :destination, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at destination distance email height id id_value length name patronymic
       phone_number point_of_departure price surname updated_at weight width]
  end
end
