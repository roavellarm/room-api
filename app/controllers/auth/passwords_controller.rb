# frozen_string_literal: true

module Auth
  class PasswordsController < DeviseTokenAuth::PasswordsController
    skip_before_action :set_user_by_token, only: %i[update edit]
    before_action :set_user_by_reset_token, only: %i[edit update]

    def update
      super
    end

    def edit
      token = @resource.create_token
      # ensure that user is confirmed
      @resource.skip_confirmation! if confirmable?
      # allow user to change password once without current_password
      @resource.update(allow_password_change: true) if recoverable_enabled?

      build_redirect(params[:redirect_url], redirect_headers(
        token.token, token.client,
        redirect_header_options
      ))
    end

    private

    def set_user_by_reset_token
      token = resource_params[:reset_password_token]
      return if token.nil?

      @resource = User.with_reset_password_token(token)

      if !@resource
        render_not_found
      elsif @resource && !@resource.reset_password_period_valid?
        render_expired_error
      else
        bypass_sign_in(@resource)
      end
    end

    def render_expired_error
      render json: {
        success: false,
        message: expired_message
      }, status: :unauthorized
    end

    def render_not_found
      render json: {
        success: false,
        message: not_found_message
      }, status: :not_found
    end

    def expired_message
      'The password change request has expired, please try again.'
    end

    def not_found_message
      'No user was found for the password request.'
    end

    def redirect_header_options
      { reset_password: true,
        reset_password_token: resource_params[:reset_password_token] }
    end

    def redirect_headers(token, client_id, redirect_header_options)
      build_redirect_headers(
        token, client_id, redirect_header_options
      )
    end

    def build_redirect(redirect_url, headers)
      redirect_to(
        @resource.build_auth_url(redirect_url, headers)
      )
    end

    def confirmable?
      confirmable_enabled? && !@resource.confirmed_at
    end
  end
end
