# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :org

  validates :title, presence: true

  def as_json(_options = {})
    { id: id,
      org: org,
      title: title,
      subtitle: subtitle,
      background_image: background_image,
      avatar_image: avatar_image }
  end
end
