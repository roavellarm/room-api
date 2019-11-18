# frozen_string_literal: true

require 'rails_helper'

describe Org, type: :model do
  subject(:org) { orange_org }

  let(:expected_hash) do
    { id: org.id,
      user_id: org.user_id,
      name: org.name,
      description: org.description,
      image: org.image,
      rooms: org.rooms,
      members: org.members }
  end

  describe '#as_json' do
    subject { org.as_json }

    it { is_expected.to eq expected_hash }
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :rooms }
  it { is_expected.to have_many :user_orgs }
  it { is_expected.to have_many(:members).through(:user_orgs) }
end
