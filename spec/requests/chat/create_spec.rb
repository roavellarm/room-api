# frozen_string_literal: true

require 'rails_helper'

describe 'POST /chat', type: :request do
  let(:params) do
    {
      room_id: cafe_room.id,
      message: 'Hey guys!'
    }.to_json
  end

  context 'with correct params' do
    before { post '/chat', params: params }

    it { expect(response).to have_http_status(:created) }
  end

  # context 'with incorrect params' do
  #   let(:params) { { foo: 'bar' }.to_json }

  #   before { post '/chat', params: params }

  #   it { expect(response).to have_http_status(:bad_request) }
  # end
end
