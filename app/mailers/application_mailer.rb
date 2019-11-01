# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'layouts/mailer'

  def mail(headers)
    super(headers) do |format|
      format.text
      format.mjml
    end
  end
end
