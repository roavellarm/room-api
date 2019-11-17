# frozen_string_literal: true

class Org < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :user_orgs, dependent: :destroy
  has_many :members, source: :user, through: :user_orgs

  def as_json(_options = {})
    { id: id,
      user_id: user.id,
      name: name,
      description: description,
      image: image }
  end
end
