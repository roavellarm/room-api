# frozen_string_literal: true

class OrgPolicy < ApplicationPolicy
  def index?
    current_user?
  end
end