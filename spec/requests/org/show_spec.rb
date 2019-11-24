# frozen_string_literal: true

require 'rails_helper'

describe 'GET /org/:id', type: :request do
  let(:expected_hash) do
    { id: banana_org.id,
      user_id: average_fred.id,
      name: 'Banana Company',
      description: 'Aliquam pharetra magna ut augue varius eget vitae est.',
      image: 'https://source.unsplash.com/random',
      rooms: [
        { id: cafe_room.id,
          org_id: cafe_room.org_id,
          title: 'Cafe',
          subtitle: 'Take a break and drink some coffe',
          background_image: 'https://picsum.photos/600/400',
          avatar_image: 'https://i.pravatar.cc/150',
          token: cafe_room.token,
          online_members: [] }
      ],
      members: [] }.to_json
  end

  before { get "/org/#{banana_org.id}" }

  it { expect(response).to have_http_status :ok }
  it { expect(response.body).to eq(expected_hash) }

  context 'with unpermitted params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { get "/org/#{banana_org.id}", params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
