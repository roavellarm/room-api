# frozen_string_literal: true

class OrgPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    current_user?
  end

  def show?
    current_user?
  end

  def add_member?
    user.present?
  end
end
