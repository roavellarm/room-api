# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
  def create?
    current_user?
  end
end
