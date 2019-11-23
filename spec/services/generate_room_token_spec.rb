# frozen_string_literal: true

require 'rails_helper'

describe GenerateRoomToken do
  subject(:generated_token) { described_class.execute(room, average_joe) }

  let(:room) do
    Room.new(
      org_id: orange_org.id,
      title: 'Hall',
      subtitle: 'A place to where you first access the company',
      background_image: 'background_image',
      avatar_image: 'avatar_image'
    )
  end

  it {
    expect { generated_token }
      .to change { room.token.blank? }.from(true).to(false)
  }

  it { expect(generated_token).not_to be nil }
end
