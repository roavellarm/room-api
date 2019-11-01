# frozen_string_literal: true

require 'rails_helper'

describe 'POST /auth/social_media/:provider', type: :request do
  let(:headers) { {} }

  context 'with correct params' do
    context 'with facebook provider' do
      let(:request_url) do
        <<-TEXT
          https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_KEY']}&client_secret=#{ENV['FACEBOOK_SECRET']}&grant_type=client_credentials
        TEXT
      end

      let(:body_response) do
        {
          'access_token' => 'access_token'
        }.to_json
      end

      let(:params) do
        {
          'token_id' => 'token_id',
          'input_token' => 'input_token',
          'email' => 'foobar@bar.com',
          'name' => 'foobar'
        }
      end

      before do
        stub_request(:get, 'https://graph.facebook.com/debug_token?access_token=access_token&input_token=input_token')
          .with(
            headers: {
              'Connection' => 'close',
              'Host' => 'graph.facebook.com',
              'User-Agent' => 'http.rb/4.1.1'
            }
          )
          .to_return(status: 200, body: '', headers: {})

        stub_request(:get, request_url.strip)
          .with(
            headers: {
              'Connection' => 'close',
              'Host' => 'graph.facebook.com',
              'User-Agent' => 'http.rb/4.1.1'
            }
          )
          .to_return(status: 200, body: body_response, headers: {})

        post '/auth/social_media/facebook', params: params.to_json
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context 'with google provider' do
      let(:params) do
        {
          'token_id' => 'token_id',
          'email' => 'bar@bar.com',
          'given_name' => 'foobar',
          'family_name' => 'baz'
        }
      end

      before do
        stub_request(:get, 'https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=token_id')
          .with(
            headers: {
              'Connection' => 'close',
              'Host' => 'www.googleapis.com',
              'User-Agent' => 'http.rb/4.1.1'
            }
          )
          .to_return(status: 200, body: params.to_json, headers: {})

        post '/auth/social_media/google', params: params.to_json
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { post '/auth/social_media/facebook', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end

  context 'without provider' do
    let(:params) do
      {
        'token_id' => 'token_id',
        'email' => 'bar@bar.com',
        'given_name' => 'foobar',
        'family_name' => 'baz'
      }.to_json
    end

    before { post '/auth/social_media/:provider', params: params }

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it 'returns the correct error' do
      expect(response.body).to eq(
        { user_empty: 'User can not be empty' }.to_json
      )
    end
  end
end
