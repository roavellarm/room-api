# frozen_string_literal: true

class AddImageToOrgs < ActiveRecord::Migration[5.2]
  def change
    add_column :orgs, :image, :string
  end
end
