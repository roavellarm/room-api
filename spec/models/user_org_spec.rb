# frozen_string_literal: true

require 'rails_helper'

describe UserOrg, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :org }
  it { is_expected.to validate_presence_of :owner }
  it { is_expected.to validate_presence_of :member }
end
