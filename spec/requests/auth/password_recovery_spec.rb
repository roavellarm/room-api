# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /auth/password', type: :request do
  include_context 'with current_user'

  let(:reset_headers) { { 'uid': '', 'client': '', 'access-token': '' } }

  let(:correct_params) do
    { password: 'new_password',
      password_confirmation: 'new_password',
      reset_password_token: reset_tokens[0] }.to_json
  end

  let(:incorrect_params) { { reset_password_token: reset_tokens[0] }.to_json }

  let!(:reset_tokens) do
    Devise.token_generator.generate(User, :reset_password_token)
  end

  before do
    current_user.update(
      reset_password_sent_at: 1.minute.ago,
      reset_password_token: reset_tokens[1]
    )
  end

  context 'with edit page being accessed' do
    before do
      get '/auth/password/edit', params: {
        redirect_url: 'redirect.com',
        reset_password_token: reset_tokens[0]
      }
    end

    it { expect(response).to have_http_status(:found) }
    it { expect(response.body).to include('You are being') }
    it { expect(response.body).to include('redirect.com?access-token=') }
  end

  context 'without params' do
    before { put '/auth/password', params: {}.to_json, headers: reset_headers }

    it { expect(response).to have_http_status(:unauthorized) }

    it 'returns the correct error' do
      expect(response.body)
        .to eq({ success: false, errors: ['Unauthorized'] }.to_json)
    end
  end

  context 'with incorrect params' do
    before do
      put '/auth/password', params: incorrect_params, headers: reset_headers
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  context 'with incorrect reset token' do
    before do
      get '/auth/password/edit', params: {
        redirect_url: 'redirect.com',
        reset_password_token: 'wrong_token'
      }
    end

    it { expect(response).to have_http_status(:not_found) }

    it 'returns the correct error' do
      expect(response.body).to eq({
        success: false,
        message: not_found_message
      }.to_json)
    end
  end

  context 'with expired reset token' do
    before do
      current_user.update(
        reset_password_sent_at: Devise.reset_password_within.ago.utc - 1.second
      )

      put '/auth/password', params: correct_params, headers: reset_headers
    end

    it { expect(response).to have_http_status(:unauthorized) }

    it 'returns the correct error' do
      expect(response.body).to eq({
        success: false,
        message: expired_message
      }.to_json)
    end
  end

  context 'with correct params' do
    before do
      put '/auth/password', params: correct_params, headers: reset_headers
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)['success']).to eq(true) }
    it {
      expect(JSON.parse(response.body)['message']).to eq(
        'Your password has been successfully updated.'
      )
    }
  end

  private

  def expired_message
    'The password change request has expired, please try again.'
  end

  def not_found_message
    'No user was found for the password request.'
  end
end
