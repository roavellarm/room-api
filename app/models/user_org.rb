# frozen_string_literal: true

class UserOrg < ApplicationRecord
  belongs_to :user
  belongs_to :org

  validates :member, :owner, presence: true
end
