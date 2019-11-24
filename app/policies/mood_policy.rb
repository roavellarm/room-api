# frozen_string_literal: true

class MoodPolicy < ApplicationPolicy
  def change_mood?
    current_user?
  end
end
