# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :org, foreign_key: true
      t.string :title
      t.string :subtitle
      t.string :background_image
      t.string :avatar_image

      t.timestamps
    end
  end
end
