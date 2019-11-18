# frozen_string_literal: true

require 'rails_helper'

describe 'POST /room', type: :request do
  let(:params) do
    {
      org_id: orange_org.id,
      title: 'Cafe',
      subtitle: 'A room to take a power nap with coffe',
      background_image: 'background_image',
      avatar_image: 'avatar_image'
    }.to_json
  end

  context 'with correct params' do
    before { post '/room', params: params }

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { post '/room', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
