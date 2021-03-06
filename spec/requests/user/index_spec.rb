# frozen_string_literal: true

require 'rails_helper'

describe 'GET /user', type: :request do
  let(:expected_hash) do
    [{ id: current_user.id,
       first_name: 'Current',
       last_name: 'User',
       email: 'current.user@email.com',
       image: 'current_image_url',
       mood: current_user.mood },

     { id: average_fred.id,
       first_name: 'Fred',
       last_name: 'Average',
       email: 'fred@email.com',
       image: 'fred_image_url',
       mood: average_fred.mood },

     { id: average_joe.id,
       first_name: 'Joe',
       last_name: 'Average',
       email: 'joe@email.com',
       image: 'joe_image_url',
       mood: average_joe.mood },

     { id: average_sally.id,
       first_name: 'Sally',
       last_name: 'Average',
       email: 'sally@email.com',
       image: 'sally_image_url',
       mood: average_sally.mood }].to_json
  end

  context 'without params' do
    before { get '/user' }

    it { expect(response).to have_http_status :ok }
    # it { expect(response.body).to eq(expected_hash) }
    # it { expect(JSON.parse(response.body).length).to eq(4) }
  end

  context 'with unpermitted params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { get '/user', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
