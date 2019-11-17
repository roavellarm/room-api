# frozen_string_literal: true

class AddUserRefToOrgs < ActiveRecord::Migration[5.2]
  def change
    add_reference :orgs, :user, foreign_key: true
  end
end
