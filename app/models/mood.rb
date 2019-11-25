# frozen_string_literal: true

class Mood < ApplicationRecord
  validates :name, presence: true

  has_many :users

  def as_json(_options = {})
    { id: id,
      name: name }
  end
end
