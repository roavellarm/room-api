# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /room_access', type: :request do
  let(:params) { { id: room.id } }

  let(:user) { current_user }

  let(:room) { cafe_room }

  context 'with current user' do
    let(:expected_body) do
      { id: cafe_room.id,
        org_id: banana_org.id,
        title: 'Cafe',
        subtitle: 'Take a break and drink some coffe',
        background_image: 'https://picsum.photos/600/400',
        avatar_image: 'https://i.pravatar.cc/150',
        token: nil,
        online_members: [
          { id: current_user.id,
            first_name: 'Current',
            last_name: 'User',
            email: 'current.user@email.com',
            image: nil,
            status: nil,
            mood: current_user.mood }
        ] }.to_json
    end

    before do
      current_user.update(room: music_room)
      put '/room_access', params: params.to_json
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq(expected_body) }
    it { expect(expected_body).to eq(room.reload.as_json.to_json) }
    it { expect(music_room.users).to eq([]) }
    it { expect(music_room.as_json[:online_members]).to eq([]) }
  end

  context 'without current_user' do
    let(:headers) { { 'access-token': nil } }

    before { put '/room_access', params: params.to_json, headers: headers }

    it { expect(response).to have_http_status(:unauthorized) }
  end

  context 'with bad parameters' do
    let(:params) { { foo: 'bar' } }

    before { put '/room_access', params: params.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
