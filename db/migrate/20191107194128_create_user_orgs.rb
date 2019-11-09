# frozen_string_literal: true

class CreateUserOrgs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_orgs do |t|
      t.references :user, foreign_key: true
      t.references :org, foreign_key: true
      t.boolean :owner, null: false
      t.boolean :member, null: false

      t.timestamps
    end
  end
end
