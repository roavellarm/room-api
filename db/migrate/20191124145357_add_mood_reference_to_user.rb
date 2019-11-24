# frozen_string_literal: true

class AddMoodReferenceToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :mood, foreign_key: true, null: true
  end
end
