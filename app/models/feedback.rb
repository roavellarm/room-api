# frozen_string_literal: true

class Feedback < ApplicationRecord
  validates :positives, :negatives, presence: true

  def as_json(_options = {})
    {
      id: id,
      name: name,
      email: email,
      positives: positives,
      negatives: negatives
    }
  end
end
