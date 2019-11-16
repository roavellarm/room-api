# frozen_string_literal: true

require 'rails_helper'

describe 'POST /org', type: :request do
  let(:params) do
    {
      name: 'Orange Organization',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      image: 'https://source.unsplash.com/random'
    }.to_json
  end

  context 'with correct params' do
    before { post '/org', params: params }

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { post '/org', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
