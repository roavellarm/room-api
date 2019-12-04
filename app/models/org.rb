# frozen_string_literal: true

class Org < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :user_orgs, dependent: :destroy
  has_many :members, source: :user, through: :user_orgs

  def as_json(_options = {})
    {
      id: id,
      user: user.as_json,
      name: name,
      description: description,
      image: image,
      rooms: rooms,
      members: members.as_json
    }
  end
end
