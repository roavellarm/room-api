# frozen_string_literal: true

class RemoveFieldsFromUserOrgs < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_orgs, :owner, :boolean
    remove_column :user_orgs, :member, :boolean
  end
end
