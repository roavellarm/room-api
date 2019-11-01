# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  layout 'layouts/mailer'
  default template_path: 'devise/mailer'
  default from: 'from@example.com'

  # rubocop:disable Lint/UnusedMethodArgument
  def reset_password_instructions(record, token, opts = {})
    @token = token
    @resource = record
    # Custom logic to send the email with MJML
    mail(
      to: record.email,
      subject: 'Reset password instructions'
    ) do |format|
      format.text
      format.mjml
    end
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
