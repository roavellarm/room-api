# frozen_string_literal: true

require 'rails_helper'

describe 'GET /org', type: :request do
  let(:expected_hash) do
    [
      { id: banana_org.id,
        user_id: average_fred.id,
        name: 'Banana Company',
        description: 'Aliquam pharetra magna ut augue varius eget vitae est.',
        image: 'https://source.unsplash.com/random',
        rooms: [
          { id: cafe_room.id,
            org_id: cafe_room.org_id,
            title: 'Cafe',
            subtitle: 'Take a break and drink some coffe',
            background_image: 'https://picsum.photos/600/400',
            avatar_image: 'https://i.pravatar.cc/150',
            token: cafe_room.token,
            online_members: [] }
        ],
        members: [] },
      { id: orange_org.id,
        user_id: average_joe.id,
        name: 'Orange Company',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing '\
        'elit.',
        image: 'https://source.unsplash.com/random',
        rooms: [],
        members: [] }
    ].to_json
  end

  context 'without params' do
    before { get '/org' }

    it { expect(response).to have_http_status :ok }
    it { expect(response.body).to eq(expected_hash) }
    it { expect(JSON.parse(response.body).length).to eq(2) }
  end

  context 'with unpermitted params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { get '/org', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
