# frozen_string_literal: true

class CreateMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :moods do |t|
      t.string :name

      t.timestamps
    end
  end
end
