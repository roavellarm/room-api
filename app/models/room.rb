# frozen_string_literal: true

class Room < ApplicationRecord
  # belongs_to :organization
  # belongs_to :user, dependent: :destroy

  def as_json(_options = {})
    {
      id: id,
      title: title,
      subtitle: subtitle,
      background_image: background_image,
      avatar_image: avatar_image
    }
  end
end
