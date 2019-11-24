# frozen_string_literal: true

class ChatPolicy < ApplicationPolicy
  def create?
    current_user?
  end

  def show?
    current_user?
  end
end
