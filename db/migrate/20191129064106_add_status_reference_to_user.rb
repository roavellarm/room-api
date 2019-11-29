# frozen_string_literal: true

class AddStatusReferenceToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :status, foreign_key: true, null: true
  end
end
