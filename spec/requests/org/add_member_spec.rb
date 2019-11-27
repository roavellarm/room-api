# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /org/:id/add_member', type: :request do
  let(:params) { { email: average_sally.email }.to_json }

  let(:org) do
    Org.create!(
      user: current_user,
      name: 'Foo Company',
      description: 'Lorem ipsum dolor sit amet',
      image: 'https://source.unsplash.com/random'
    )
  end

  let(:expected_hash) do
    {
      id: org.id,
      user_id: current_user.id,
      name: 'Foo Company',
      description: 'Lorem ipsum dolor sit amet',
      image: 'https://source.unsplash.com/random',
      rooms: [],
      members: [
        {
          id: average_sally.id,
          first_name: 'Sally',
          last_name: 'Average',
          email: 'sally@email.com',
          image: nil,
          mood: nil
        }
      ]
    }.to_json
  end

  context 'with correct params' do
    before { put "/org/#{org.id}/add_member", params: params }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq(expected_hash) }
  end

  context 'without current_user' do
    let(:headers) { { 'access-token': nil } }

    before { put "/org/#{org.id}/add_member", params: params, headers: headers }

    it { expect(response).to have_http_status(:unauthorized) }
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { put "/org/#{org.id}/add_member", params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
