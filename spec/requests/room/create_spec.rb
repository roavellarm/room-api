# frozen_string_literal: true

require 'rails_helper'

describe 'POST /room', type: :request do
  let(:params) do
    {
      org_id: orange_org.id,
      title: 'Hall',
      subtitle: 'A place to where you first access the company',
      background_image: 'background_image',
      avatar_image: 'avatar_image'
    }.to_json
  end

  context 'with correct params' do
    before { post '/room', params: params }

    it { expect(response).to have_http_status(:created) }

    context 'with token aldeady taken' do
      let(:last_room_id) { orange_org.rooms.last.id + 1 }

      let(:room) do
        Room.create!(
          org_id: orange_org.id,
          title: 'Hall',
          subtitle: 'A place to where you first access the company',
          background_image: 'background_image',
          avatar_image: 'avatar_image',
          token: generate_same_token
        )
      end

      let(:error_message) do
        {
          id: 'unprocessable_entity',
          message: 'Token has already been taken'
        }.to_json
      end

      before do
        last_room_id
        room
        post '/room', params: params
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(orange_org.rooms.last.id).to be(last_room_id) }
      it { expect(response.body).to eq(error_message) }
    end
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { post '/room', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end

  private

  # rubocop:disable Metrics/AbcSize
  def generate_same_token
    (number_name(current_user.id) + current_user.first_name +
     current_user.last_name + number_name(orange_org.id) + orange_org.name +
     number_name(orange_org.rooms.last.id + 2) + 'Hall')
      .gsub(/\s+/, '').downcase.reverse!
  end
  # rubocop:enable Metrics/AbcSize

  def write_number(digit)
    numbers = %w[zero one two three four five six seven eight nine]
    numbers[digit.to_i]
  end

  def number_name(num)
    splitted_number = num.to_s.split('')
    result = ''
    splitted_number.each do |digit|
      result += write_number(digit)
    end
    result
  end
end
