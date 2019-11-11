# frozen_string_literal: true

require 'rails_helper'

describe Org, type: :model do
  subject(:org) { orange_org }

  let(:expected_hash) do
    { id: org.id,
      name: org.name,
      description: org.description }
  end

  describe '#as_json' do
    subject { org.as_json }

    it { is_expected.to eq expected_hash }
  end

  it { is_expected.to validate_presence_of :name }
end
