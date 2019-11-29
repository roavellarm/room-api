# frozen_string_literal: true

class Status < ApplicationRecord
  validates :status, presence: true
  has_many :users, dependent: :destroy

  def as_json(_options = {})
    { id: id, status: status }
  end
end
