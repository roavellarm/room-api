# frozen_string_literal: true

class Mood < ApplicationRecord
  validates :name, presence: true

  has_many :users

  def as_json(_options = {})
    { name: name }
  end
end
