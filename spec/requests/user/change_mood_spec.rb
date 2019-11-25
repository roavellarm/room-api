# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /user/change_mood', type: :request do
  let(:params) { { mood: 'tired' } }

  let(:expected_hash) do
    {
      id: current_user.id,
      first_name: 'Current',
      last_name: 'User',
      email: 'current.user@email.com',
      mood: {
        id: tired_mood.id,
        name: 'tired'
      }
    }.to_json
  end

  before do
    tired_mood
    put '/user/change_mood', params: params.to_json
  end

  it { expect(response).to have_http_status(:ok) }
  it { expect(response.body).to eq(expected_hash) }
  it { expect(JSON.parse(response.body).length).to eq(5) }
end
