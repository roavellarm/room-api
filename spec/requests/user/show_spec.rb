# frozen_string_literal: true

require 'rails_helper'

describe 'GET /user/:id', type: :request do
  let(:expected_hash) do
    {
      id: average_joe.id,
      first_name: 'Joe',
      last_name: 'Average',
      email: 'joe@email.com',
      mood: nil
    }.to_json
  end

  before { get "/user/#{average_joe.id}" }

  it { expect(response).to have_http_status :ok }
  it { expect(response.body).to eq(expected_hash) }

  context 'with unpermitted params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { get "/user/#{average_joe.id}", params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
