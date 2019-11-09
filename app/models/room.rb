# frozen_string_literal: true

class Room < ApplicationRecord
  def as_json(_options = {})
    { id: id,
      title: title,
      subtitle: subtitle,
      background_image: background_image,
      avatar_image: avatar_image }
  end
end
