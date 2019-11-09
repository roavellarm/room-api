# frozen_string_literal: true

class UserOrg < ApplicationRecord
  belongs_to :user
  belongs_to :org
end
