# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /user/:id/leave_rooms', type: :request do
  let(:user) { current_user }

  context 'with current user' do
    let(:expected_body) do
      { id: user.id,
        first_name: 'Current',
        last_name: 'User',
        email: 'current.user@email.com',
        image: nil,
        status: nil,
        mood: nil }.to_json
    end

    before do
      current_user.update(room: music_room)
      put "/user/#{user.id}/leave_rooms"
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(user.reload.as_json.to_json).to eq(expected_body) }
    it { expect(music_room.users).to eq([]) }
    it { expect(music_room.as_json[:online_members]).to eq([]) }
  end

  context 'when the current user is another user' do
    let(:user) { average_joe }

    before { put "/user/#{user.id}/leave_rooms" }

    it { expect(response).to have_http_status(:ok) }
  end

  context 'without current_user' do
    let(:headers) { { 'access-token': nil } }

    before { put "/user/#{user.id}/leave_rooms", headers: headers }

    it { expect(response).to have_http_status(:ok) }
  end

  context 'with bad parameters' do
    let(:params) { { foo: 'bar' } }

    before { put "/user/#{user.id}/leave_rooms", params: params.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end

  context 'with user not found' do
    before { put "/user/#{user.id + 1000}" }

    it { expect(response).to have_http_status(:not_found) }
  end
end
