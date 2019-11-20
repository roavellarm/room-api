# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :org

  validates :title, presence: true

  def as_json(_options = {})
    { id: id,
      org_id: org.id,
      title: title,
      subtitle: subtitle,
      background_image: background_image,
      avatar_image: avatar_image,
      token: token }
  end
end
