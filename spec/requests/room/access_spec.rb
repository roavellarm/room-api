# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /room-access', type: :request do
  let(:headers) { {} }

  let(:params) { { id: room.id, user_id: user.id } }

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
            email: 'current.user@email.com' }
        ] }.to_json
    end

    before do
      music_room.users.append(current_user)
      put '/room-access', params: params.to_json, headers: headers
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq(expected_body) }
    it { expect(expected_body).to eq(room.reload.as_json.to_json) }
    #   context 'when the current_user is ...' do ...
    #   it { expect(response).to have_http_status(:forbidden) }
  end

  # context 'without current_user' do
  #   let(:headers) { { 'access-token': nil } }

  #   it { expect(response).to have_http_status(:unauthorized) }
  # end

  # context 'with bad parameters' do
  #   let(:params) { { foo: 'bar' } }

  #   it { expect(response).to have_http_status(:bad_request) }
  # end
end