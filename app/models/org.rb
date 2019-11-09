# frozen_string_literal: true

class Org < ApplicationRecord
  validates :name, presence: true

  has_many :rooms
  has_many :user_orgs
  has_many :users, through: :user_orgs

  def as_json(_options = {})
    { id: id,
      name: name,
      description: description }
  end
end
