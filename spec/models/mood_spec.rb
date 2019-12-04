# frozen_string_literal: true

require 'rails_helper'

describe Mood, type: :model do
  subject(:mood) { Mood.new(name: 'tired') }

  let(:expected_hash) { { name: 'tired' } }

  describe '#as_json' do
    subject { mood.as_json }

    it { is_expected.to eq(expected_hash) }
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :users }
end
