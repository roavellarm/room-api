# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    current_user?
  end

  def show?
    current_user?
  end

  def update?
    user.id == record.id
  end

  def leave_rooms?
    user.id == record.id
  end
end
