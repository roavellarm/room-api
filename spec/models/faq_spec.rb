# frozen_string_literal: true

require 'rails_helper'

describe Faq, type: :model do
  let(:faq) do
    Faq.new(
      question: 'Foo question',
      answer: 'Foo answer'
    )
  end

  it { is_expected.to validate_presence_of :question }
  it { is_expected.to validate_presence_of :answer }
  it { expect(faq.sorting).to eq(0) }

  describe '#as_json' do
    subject { faq.as_json }

    let(:expected_hash) do
      {
        id: faq.id,
        question: 'Foo question',
        answer: 'Foo answer'
      }
    end

    it { is_expected.to eq(expected_hash) }
  end
end
