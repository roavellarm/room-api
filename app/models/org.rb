# frozen_string_literal: true

class Org < ApplicationRecord
  has_many :user_orgs
  has_many :users, through: :user_orgs

  has_many :rooms
end
