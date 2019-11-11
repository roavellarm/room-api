# frozen_string_literal: true

class SocialMediaController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def auth
    result = create_user_from_login
    if result[:success]
      @user = result[:payload][:user]
      @token = result[:payload][:token]
      sign_in_with_headers
      render status: :ok, json: @user.token_validation_response
    else
      render status: :unprocessable_entity, json: result[:errors]
    end
  end

  private

  def create_user_from_login
    CreateUserFromLoginProvider.execute(
      name: params['name'], email: params['email'],
      token_id: params['token_id'], given_name: params['given_name'],
      family_name: params['family_name'], provider: params['provider'],
      input_token: params['input_token']
    )
  end

  def sign_in_with_headers
    make_headers
    sign_in(:user, @user, store: false, bypass: false)
  end

  def make_headers
    headers['access-token'] = (@token['access-token']).to_s
    headers['client'] =  (@token['client']).to_s
    headers['expiry'] =  (@token['expiry']).to_s
    headers['uid'] = @user.uid
    headers['token-type'] = (@token['token-type']).to_s
  end
end
