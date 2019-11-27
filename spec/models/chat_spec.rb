# frozen_string_literal: true

require 'rails_helper'

describe Chat, type: :model do
  let(:chat) do
    Chat.new(
      room_id: cafe_room.id,
      message: 'Some message',
      user: average_joe
    )
  end

  it { is_expected.to validate_presence_of :message }
  it { is_expected.to validate_presence_of :room }
  it { is_expected.to validate_presence_of :user }

  describe '#as_json' do
    subject { chat.as_json }

    let(:expected_hash) do
      { id: chat.id,
        user_email: 'joe@email.com',
        user_name: 'Joe',
        message: 'Some message',
        created_at: chat.created_at }
    end

    it { is_expected.to eq(expected_hash) }
  end
end
