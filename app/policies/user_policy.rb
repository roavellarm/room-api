# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    current_user?
  end

  def change_mood?
    current_user?
  end
end
