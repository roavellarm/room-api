# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  subject(:room) { cafe_room }

  let(:expected_hash) do
    {
      id: room.id,
      title: room.title,
      subtitle: room.subtitle,
      background_image: room.background_image,
      avatar_image: room.avatar_image
    }
  end

  describe '#as_json' do
    subject { room.as_json }

    it { is_expected.to eq(expected_hash) }
  end
end
