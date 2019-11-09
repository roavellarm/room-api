# frozen_string_literal: true

require 'rails_helper'

describe 'GET /user', type: :request do
  let(:expected_hash) do
    [{ id: current_user.id,
       first_name: 'Current',
       last_name: 'User',
       email: 'current.user@email.com' },

     { id: average_fred.id,
       first_name: 'Fred',
       last_name: 'Average',
       email: 'fred@email.com' },

     { id: average_joe.id,
       first_name: 'Joe',
       last_name: 'Average',
       email: 'joe@email.com' },

     { id: average_sally.id,
       first_name: 'Sally',
       last_name: 'Average',
       email: 'sally@email.com' }].to_json
  end

  before { get '/user' }

  it { expect(response).to have_http_status :ok }
  it { expect(response.body).to eq(expected_hash) }
end
