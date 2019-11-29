# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
