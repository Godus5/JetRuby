# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.float :weight
      t.float :length
      t.float :width
      t.float :height
      t.float :distance
      t.float :price
      t.string :point_of_departure
      t.string :destination
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
