# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :message, :user, :room, presence: true

  def as_json(_options = {})
    { id: id,
      user_email: user.email,
      user_name: user.first_name,
      message: message,
      created_at: created_at }
  end
end
