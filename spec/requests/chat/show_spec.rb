# frozen_string_literal: true

require 'rails_helper'

describe 'GET /chat/:id', type: :request do
  let(:expected_hash) do
    [
      {
        id: chat_message.id,
        user_email: 'fred@email.com',
        user_name: 'Fred',
        message: 'Hey guys!',
        created_at: chat_message.created_at
      },
      {
        id: chat_message2.id,
        user_email: 'joe@email.com',
        user_name: 'Joe',
        message: "What's up, Fred?",
        created_at: chat_message2.created_at
      },
      {
        id: chat_message3.id,
        user_email: 'sally@email.com',
        user_name: 'Sally',
        message: 'Hey, Fred!',
        created_at: chat_message3.created_at
      }
    ].to_json
  end

  before { get "/chat/#{cafe_room.id}" }

  it { expect(response).to have_http_status :ok }
  it { expect(response.body).to eq(expected_hash) }

  # context 'with unpermitted params' do
  #   let(:params) { { foo: 'bar' }.to_json }

  #   before { get "/chat/#{cafe_room.id}", params: params }

  #   it { expect(response).to have_http_status(:bad_request) }
  # end
end
