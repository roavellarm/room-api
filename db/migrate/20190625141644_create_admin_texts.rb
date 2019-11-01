# frozen_string_literal: true

class CreateAdminTexts < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_texts do |t|
      t.string :field, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
