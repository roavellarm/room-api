# frozen_string_literal: true

class AddTokenToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :token, :string, unique: true
  end
end
