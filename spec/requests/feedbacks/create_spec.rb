# frozen_string_literal: true

require 'rails_helper'

describe 'POST /feedback', type: :request do
  let(:params) do
    {
      name: 'Some Name',
      email: 'some@email.com',
      positives: positives,
      negatives: negatives
    }.to_json
  end

  context 'with correct params' do
    before { post '/feedback', params: params }

    it { expect(response).to have_http_status(:created) }
  end

  context 'with incorrect params' do
    let(:params) { { foo: 'bar' }.to_json }

    before { post '/feedback', params: params }

    it { expect(response).to have_http_status(:bad_request) }
  end

  private

  def positives
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '\
    'Nulla imperdiet ornare massa, eget laoreet nulla gravida laoreet. '\
    'Aliquam convallis nulla massa, sit amet ullamcorper purus gravida '\
    'porta. Cras eleifend odio ut nunc lobortis venenatis. Fusce porttitor '\
    'blandit metus, in sodales velit mattis eget. Nam egestas magna in eros '\
    'interdum hendrerit. Donec molestie magna non est vulputate malesuada. '\
    'Sed pulvinar ex non facilisis faucibus.'
  end

  def negatives
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '\
    'Nulla imperdiet ornare massa, eget laoreet nulla gravida laoreet. '\
    'Aliquam convallis nulla massa, sit amet ullamcorper purus gravida '\
    'porta. Cras eleifend odio ut nunc lobortis venenatis. Fusce porttitor '\
    'blandit metus, in sodales velit mattis eget. Nam egestas magna in eros '\
    'interdum hendrerit. Donec molestie magna non est vulputate malesuada. '\
    'Sed pulvinar ex non facilisis faucibus.'
  end
end
