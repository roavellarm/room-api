# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /org/:id/add_member', type: :request do
  let(:params) { { email: average_sally.email }.to_json }

  let(:org) do
    Org.create!(
      user: current_user,
      name: 'Foo Company',
      description: 'Lorem ipsum dolor sit amet',
      image: 'https://source.unsplash.com/random'
    )
  end

  context 'with correct params' do
    describe 'when the current user is the owner of the org' do
      let(:expected_hash) do
        {
          id: org.id,
          user: current_user,
          name: 'Foo Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random',
          rooms: [],
          members: [
            {
              id: average_sally.id,
              first_name: 'Sally',
              last_name: 'Average',
              email: 'sally@email.com',
              image: nil,
              status: nil,
              mood: nil
            }
          ]
        }.to_json
      end

      before { put "/org/#{org.id}/add_member", params: params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to eq(expected_hash) }
    end

    describe 'when the current user is a member of the org' do
      let(:params) { { email: average_joe.email }.to_json }

      let(:org) do
        Org.create!(
          user: average_sally,
          name: 'Sallys Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random'
        )
      end

      let(:expected_hash) do
        {
          id: org.id,
          user: average_sally,
          name: 'Sallys Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random',
          rooms: [],
          members: [
            {
              id: current_user.id,
              first_name: 'Current',
              last_name: 'User',
              email: 'current.user@email.com',
              image: nil,
              status: nil,
              mood: nil
            },
            {
              id: average_joe.id,
              first_name: 'Joe',
              last_name: 'Average',
              email: 'joe@email.com',
              image: nil,
              status: nil,
              mood: nil
            }
          ]
        }.to_json
      end

      before do
        org.members.append(current_user)
        put "/org/#{org.id}/add_member", params: params
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to eq(expected_hash) }
      it { expect(org.reload.as_json.to_json).to eq(expected_hash) }
    end

    describe 'when the user to be added is already a member of the org' do
      let(:params) { { email: average_joe.email }.to_json }

      let(:org) do
        Org.create!(
          user: average_sally,
          name: 'Sallys Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random'
        )
      end

      let(:expected_hash) do
        {
          id: org.id,
          user: average_sally,
          name: 'Sallys Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random',
          rooms: [],
          members: [
            {
              id: current_user.id,
              first_name: 'Current',
              last_name: 'User',
              email: 'current.user@email.com',
              image: nil,
              status: nil,
              mood: nil
            },
            {
              id: average_joe.id,
              first_name: 'Joe',
              last_name: 'Average',
              email: 'joe@email.com',
              image: nil,
              status: nil,
              mood: nil
            }
          ]
        }.to_json
      end
      let(:error_message) do
        { success: false,
          errors: { id: 'unprocessable_entity',
                    message: 'The user is already a member of this org' } }
      end

      before do
        org.members.append(average_joe)
        org.members.append(current_user)
        put "/org/#{org.id}/add_member", params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).to eq(error_message.to_json) }
      it { expect(org.reload.as_json.to_json).to eq(expected_hash) }
    end

    describe 'when the user to be added is not register yet' do
      let(:params) { { email: 'not_register@email.com' }.to_json }

      let(:org) do
        Org.create!(
          user: current_user,
          name: 'Current User Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random'
        )
      end

      let(:expected_hash) do
        {
          id: org.id,
          user: current_user,
          name: 'Current User Company',
          description: 'Lorem ipsum dolor sit amet',
          image: 'https://source.unsplash.com/random',
          rooms: [],
          members: []
        }.to_json
      end
      let(:error_message) do
        { success: false,
          errors: { id: 'not_found',
                    message: 'The user is not registered already in the app' } }
      end

      before { put "/org/#{org.id}/add_member", params: params }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq(error_message.to_json) }
      it { expect(org.reload.as_json.to_json).to eq(expected_hash) }
    end
  end

  context 'without current_user' do
    let(:headers) { { 'access-token': nil } }

    before { put "/org/#{org.id}/add_member", params: params, headers: headers }

    it { expect(response).to have_http_status(:unauthorized) }
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { put "/org/#{org.id}/add_member", params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
