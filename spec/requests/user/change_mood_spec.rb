# frozen_string_literal: true

require 'rails_helper'

describe 'PUT /user/change_mood', type: :request do
  # let(:user) { current_user }
  let(:params) { { mood: 'tired' }.to_json }

  before do
    tired_mood
    put '/user/change_mood', params: params
  end

  it { expect(response).to have_http_status :ok }
  # it { expect(response.body).to eq(expected_hash) }
  # it { expect(JSON.parse(response.body).length).to eq(4) }
end
