# frozen_string_literal: true

require 'rails_helper'

describe Feedback, type: :model do
  let(:feedback) do
    Feedback.new(
      name: 'Some Name',
      email: 'some@email.com',
      positives: positives,
      negatives: negatives
    )
  end

  it { is_expected.to validate_presence_of :positives }
  it { is_expected.to validate_presence_of :negatives }

  describe '#as_json' do
    subject { feedback.as_json }

    let(:expected_hash) do
      { id: feedback.id,
        name: 'Some Name',
        email: 'some@email.com',
        positives: positives,
        negatives: negatives }
    end

    it { is_expected.to eq(expected_hash) }
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
