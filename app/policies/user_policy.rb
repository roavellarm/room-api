# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    user.id == record.id
  end

  def leave_rooms?
    true
  end
end
