# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /user', type: :request do
  let(:params) do
    { first_name: 'Foo',
      last_name: 'Bar',
      email: 'foo@bar.com',
      image: 'foo_bar_image_url',
      mood: 'Very satisfied' }
  end

  let(:user) { current_user }

  context 'with current user' do
    context 'when the current user updates all fields' do
      let(:expected_body) do
        { id: user.id,
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          image: 'foo_bar_image_url',
          status: nil,
          mood: { name: 'Very satisfied' } }.to_json
      end

      before { put "/user/#{user.id}", params: params.to_json }

      it { expect(response).to have_http_status(:ok) }
      it { expect(user.reload.as_json.to_json).to eq(expected_body) }
    end

    context 'when the current user is another user' do
      let(:user) { average_joe }

      before { put "/user/#{user.id}", params: params.to_json }

      it { expect(response).to have_http_status(:forbidden) }
    end

    context 'when updating only the user mood' do
      let(:params) { { mood: 'Very satisfied' } }
      let(:expected_body) do
        { id: user.id,
          first_name: 'Current',
          last_name: 'User',
          email: 'current.user@email.com',
          image: nil,
          status: nil,
          mood: { name: 'Very satisfied' } }.to_json
      end

      before { put "/user/#{user.id}", params: params.to_json }

      it { expect(response).to have_http_status(:ok) }
      it { expect(user.reload.as_json.to_json).to eq(expected_body) }
    end
  end

  context 'without current_user' do
    let(:headers) { { 'access-token': nil } }

    before { put "/user/#{user.id}", params: params.to_json, headers: headers }

    it { expect(response).to have_http_status(:unauthorized) }
  end

  context 'with bad parameters' do
    let(:params) { { foo: 'bar' } }

    before { put "/user/#{user.id}", params: params.to_json }

    it { expect(response).to have_http_status(:bad_request) }
  end

  context 'with user not found' do
    before { put "/user/#{user.id + 1000}", params: params.to_json }

    it { expect(response).to have_http_status(:not_found) }
  end
end
