# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  subject(:user) { average_joe }

  # let(:owner) { owner_role }
  let(:expected_hash) do
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email
    }
  end

  # it 'finds a UserRole based on a user and a role as a string' do
  #   user_role = user.as_a 'Owner'
  #   expect(user_role.role).to eq(owner)
  # end

  # it 'finds a UserRole based on a user and a role as an object' do
  #   user_role = user.as_a owner_role
  #   expect(user_role.role).to eq(owner)
  # end

  describe '#as_json' do
    subject { user.as_json }

    it { is_expected.to eq(expected_hash) }
  end

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
end
