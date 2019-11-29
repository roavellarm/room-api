# frozen_string_literal: true

class ChatPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end
end
