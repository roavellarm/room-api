# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
  def create?
    true
  end

  def access?
    true
  end
end
