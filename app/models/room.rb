# frozen_string_literal: true

class Room < ApplicationRecord
  validates :title, presence: true

  belongs_to :org
  has_many :users

  def as_json(_options = {})
    { id: id,
      org_id: org.id,
      title: title,
      subtitle: subtitle,
      background_image: background_image,
      avatar_image: avatar_image,
      token: token,
      online_members: users }
  end
end
