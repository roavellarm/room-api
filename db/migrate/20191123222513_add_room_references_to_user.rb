# frozen_string_literal: true

class AddRoomReferencesToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :room, foreign_key: true, null: true
  end
end
