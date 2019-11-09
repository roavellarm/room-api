# frozen_string_literal: true

class CreateOrgs < ActiveRecord::Migration[5.2]
  def change
    create_table :orgs do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
