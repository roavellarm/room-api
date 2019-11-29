# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    current_user?
  end

  def leave_rooms?
    current_user?
  end
end
