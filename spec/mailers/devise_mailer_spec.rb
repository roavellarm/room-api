# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseMailer, type: :mailer do
  describe '#reset_password_instructions' do
    subject(:mail) do
      described_class.reset_password_instructions(current_user, 'faketoken', {})
        .deliver_now
    end

    it { expect(mail.from).to eq(['from@example.com']) }
    it { expect(mail.to).to eq([current_user.email]) }
    it {
      expect(mail.subject).to eq('Reset password instructions')
    }
  end
end
