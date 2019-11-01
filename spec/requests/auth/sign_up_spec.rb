# frozen_string_literal: true

require 'rails_helper'

describe 'POST /auth - Sign Up', type: :request do
  let(:password) { '#@&45678' }
  let(:password_confirmation) { '#@&45678' }
  let(:user) do
    {
      first_name: 'John',
      last_name: 'Connor',
      email: 'john.connor@email.com',
      password: password,
      password_confirmation: password_confirmation
    }
  end

  let(:headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  let(:params) { {} }

  let(:expected_hash) do
    {
      id: User.last.id,
      first_name: 'John',
      last_name: 'Connor',
      email: 'john.connor@email.com'
    }
  end

  context 'with valid email' do
    before do
      post '/auth', params: params.to_json
    end

    let(:params) { user }

    it { expect(response).to have_http_status(:ok) }
    it { expect(User.count).to eq(3) }

    it 'returns the created user' do
      expect(response.body).to eq({
        status: 'success',
        data: expected_hash
      }.to_json)
    end
  end

  context 'when the password is less than 8 characters' do
    let(:password) { '1234567' }
    let(:params) { user }

    before do
      post '/auth', params: params.to_json
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context 'when password confirmation does not match password' do
    let(:password_confirmation) { '1234567' }
    let(:params) { user }

    before do
      post '/auth', params: params.to_json
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context 'when the email is already taken' do
    before do
      User.create!(user)
      post '/auth', params: params.to_json
    end

    let(:params) { user }

    it { expect(response).to have_http_status(:unprocessable_entity) }

    it 'does NOT return access token header' do
      expect(response.has_header?('access-token')).to eq(false)
    end
  end
end
