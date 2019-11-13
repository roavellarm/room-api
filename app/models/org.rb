# frozen_string_literal: true

class Org < ApplicationRecord
  validates :name, :description, presence: true

  has_many :rooms, dependent: :destroy
  has_many :user_orgs, dependent: :destroy
  has_many :users, through: :user_orgs

  def as_json(_options = {})
    { id: id,
      name: name,
      description: description,
      image: image }
  end
end
