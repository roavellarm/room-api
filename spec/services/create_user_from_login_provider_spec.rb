# frozen_string_literal: true

require 'rails_helper'

describe CreateUserFromLoginProvider do
  context 'with facebook provider' do
    let(:request_url) do
      <<-TEXT
        https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_KEY']}&client_secret=#{ENV['FACEBOOK_SECRET']}&grant_type=client_credentials
      TEXT
    end

    let(:response) do
      {
        'access_token' => 'access_token'
      }.to_json
    end

    let(:service_object) do
      described_class.execute(
        provider: 'facebook', token_id: 'token_id', input_token: 'input_token',
        email: 'foobar@bar.com', name: 'foobar'
      )
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
        .to_return(status: 200, body: response, headers: {})
    end

    it do
      expect(service_object).to eq(
        payload: { user: User.last, token: service_object[:payload][:token] },
        success: true
      )
    end
  end

  context 'with google provider' do
    let(:service_object) do
      described_class.execute(
        provider: 'google', token_id: 'token_id', input_token: 'input_token',
        email: 'foobar@bar.com', name: 'foobar'
      )
    end

    let(:params) do
      {
        'provider' => 'google',
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
    end

    it {
      expect(service_object)
        .to eq(payload: {
                 user: User.last, token: service_object[:payload][:token]
               }, success: true)
    }
  end

  context 'when there is no provider' do
    let(:service_object) do
      described_class.execute(
        token_id: 'token_id', input_token: 'input_token',
        email: 'foobar@bar.com', name: 'foobar'
      )
    end

    it {
      expect(service_object)
        .to eq(
          errors: { provider_not_found: 'Provider param can not be empty' },
          success: false
        )
    }
  end

  context 'with provider incorrect' do
    let(:service_object) do
      described_class.execute(
        provider: 'provider', token_id: 'token_id', input_token: 'input_token',
        email: 'foobar@bar.com', name: 'foobar'
      )
    end

    it {
      expect(service_object)
        .to eq(
          errors: { user_empty: 'User can not be empty' },
          success: false
        )
    }
  end
end
