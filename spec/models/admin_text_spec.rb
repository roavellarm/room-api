# frozen_string_literal: true

require 'rails_helper'

describe AdminText, type: :model do
  let(:admin_text) do
    AdminText.new(field: 'foo_field', text: 'foo_text')
  end

  describe '#as_json' do
    subject { admin_text.as_json }

    let(:expected_hash) do
      {
        id: admin_text.id,
        field: admin_text.field,
        text: admin_text.text
      }
    end

    it { is_expected.to eq(expected_hash) }
  end
end
