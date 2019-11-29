# frozen_string_literal: true

class OrgPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    true
  end

  def show?
    true
  end

  def add_member?
    user.present?
  end
end
