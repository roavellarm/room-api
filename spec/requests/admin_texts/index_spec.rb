# frozen_string_literal: true

require 'rails_helper'

describe 'GET /admin_texts', type: :request do
  let(:admin_text) do
    AdminText.create!(
      field: 'foo_field',
      text: 'foo_text'
    )
  end

  let(:params) { { tags: ['foo_field'] } }
  let(:headers) { { 'Content-Type': 'application/json' } }

  context 'with text found' do
    before do
      admin_text
      get '/admin_texts', headers: headers, params: params
    end

    it { expect(response).to have_http_status(:ok) }
    it 'returns correct json' do
      expect(JSON.parse(response.body)).to eq(
        JSON.parse([{ "foo_field": 'foo_text' }].to_json)
      )
    end
  end

  context 'with text not found' do
    before do
      get '/admin_texts', headers: headers, params: params
    end

    it { expect(response).to have_http_status(:ok) }
    it 'returns correct json' do
      expect(JSON.parse(response.body)).to eq(
        JSON.parse([{ "foo_field": nil }].to_json)
      )
    end
  end

  context 'with unpermitted parameters' do
    let(:params) { { project: { foo: 'bar' } } }

    before do
      get '/admin_texts', params: params.to_json, headers: headers
    end

    it 'returns a bad request' do
      expect(response).to have_http_status(:bad_request)
    end
  end
end
