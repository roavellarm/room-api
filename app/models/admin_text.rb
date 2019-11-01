# frozen_string_literal: true

class AdminText < ApplicationRecord
  validates :field, :text, presence: true

  def as_json(_options = {})
    {
      id: id,
      field: field,
      text: text
    }
  end
end
