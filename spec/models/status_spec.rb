# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Status, type: :model do
  subject(:status) { status_available }

  let(:expected_hash) { { status: 'available' } }

  describe '#as_json' do
    subject { status.as_json }

    it { is_expected.to eq(expected_hash) }
  end

  it { is_expected.to have_many :users }
  it { is_expected.to validate_presence_of :status }
end
