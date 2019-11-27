# frozen_string_literal: true

require 'rails_helper'

describe UserOrg, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :org }
end
