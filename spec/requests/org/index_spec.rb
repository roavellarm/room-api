# frozen_string_literal: true

require 'rails_helper'

describe 'GET /org', type: :request do
  let(:expected_hash) do
    [
      {
        id: banana_org.id,
        user: {
          id: average_fred.id,
          first_name: 'Fred',
          last_name: 'Average',
          email: 'fred@email.com',
          image: nil,
          status: nil,
          mood: nil
        },
        name: 'Banana Company',
        description: 'Aliquam pharetra magna ut augue varius eget vitae est.',
        image: 'https://source.unsplash.com/random',
        rooms: [
          {
            id: cafe_room.id,
            org_id: banana_org.id,
            title: 'Cafe',
            subtitle: 'Take a break and drink some coffe',
            background_image: 'https://picsum.photos/600/400',
            avatar_image: 'https://i.pravatar.cc/150',
            token: nil,
            online_members: []
          }
        ],
        members: [
          {
            id: current_user.id,
            first_name: 'Current',
            last_name: 'User',
            email: 'current.user@email.com',
            image: nil,
            status: nil,
            mood: nil
          }
        ]
      },
      {
        id: org.id,
        user: {
          id: current_user.id,
          first_name: 'Current',
          last_name: 'User',
          email: 'current.user@email.com',
          image: nil,
          status: nil,
          mood: nil
        },
        name: 'Foo Organization',
        description: 'Lorem ipsum dolor sit amet',
        image: 'org_background_image',
        rooms: [
          {
            id: room.id,
            org_id: org.id,
            title: 'Bar',
            subtitle: 'consectetur adipiscing elit.',
            background_image: 'background_image',
            avatar_image: 'avatar_image',
            token: nil,
            online_members: []
          }
        ],
        members: [
          {
            id: current_user.id,
            first_name: 'Current',
            last_name: 'User',
            email: 'current.user@email.com',
            image: nil,
            status: nil,
            mood: nil
          }
        ]
      },
      {
        id: orange_org.id,
        user: {
          id: average_joe.id,
          first_name: 'Joe',
          last_name: 'Average',
          email: 'joe@email.com',
          image: nil,
          status: nil,
          mood: nil
        },
        name: 'Orange Company',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        image: 'https://source.unsplash.com/random',
        rooms: [
          {
            id: music_room.id,
            org_id: orange_org.id,
            title: 'Music room',
            subtitle: 'Relax and listen to some music',
            background_image: 'https://picsum.photos/600/400',
            avatar_image: 'https://i.pravatar.cc/150',
            token: nil,
            online_members: []
          }
        ],
        members: [
          {
            id: current_user.id,
            first_name: 'Current',
            last_name: 'User',
            email: 'current.user@email.com',
            image: nil,
            status: nil,
            mood: nil
          }
        ]
      }
    ].to_json
  end

  let(:user) { current_user }

  let(:org) do
    Org.create!(
      user_id: user.id,
      name: 'Foo Organization',
      description: 'Lorem ipsum dolor sit amet',
      image: 'org_background_image'
    )
  end

  let(:room) do
    Room.create!(
      org_id: org.id,
      title: 'Bar',
      subtitle: 'consectetur adipiscing elit.',
      background_image: 'background_image',
      avatar_image: 'avatar_image'
    )
  end

  context 'without params' do
    before do
      room
      UserOrg.create!(org: orange_org, user: user)
      UserOrg.create!(org: banana_org, user: user)
      get '/org'
    end

    it { expect(response).to have_http_status :ok }
    it { expect(response.body).to eq(expected_hash) }
    it { expect(JSON.parse(response.body).length).to eq(3) }
  end

  context 'with unpermitted params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { get '/org', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
