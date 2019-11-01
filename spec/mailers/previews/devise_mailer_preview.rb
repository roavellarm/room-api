# frozen_string_literal: true

# test/mailers/previews/my_mailer_preview.rb
# Preview all emails at http://localhost:3000/rails/mailers/devise_mailer
class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.last, 'faketoken', {})
  end
end
