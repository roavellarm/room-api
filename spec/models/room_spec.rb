# frozen_string_literal: true

require 'rails_helper'

describe Room, type: :model do
  subject(:room) { cafe_room }

  let(:expected_hash) do
    {
      id: room.id,
      org_id: room.org.id,
      title: room.title,
      subtitle: room.subtitle,
      background_image: room.background_image,
      avatar_image: room.avatar_image,
      token: room.token,
      online_members: room.users
    }
  end

  describe '#as_json' do
    subject { room.as_json }

    it { is_expected.to eq expected_hash }
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to belong_to :org }
  it { is_expected.to have_many :users }
end
