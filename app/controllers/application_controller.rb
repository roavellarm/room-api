# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: sign_up_keys
    devise_parameter_sanitizer.permit :account_update, keys: account_update_keys
  end

  def sign_up_keys
    %i[first_name last_name email password password_confirmation]
  end

  def account_update_keys
    %i[first_name last_name email]
  end
end
