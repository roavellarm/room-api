# frozen_string_literal: true

class CreateUserFromLoginProvider
  def self.execute(**keywords, &block)
    new(**keywords, &block).execute
  end

  def initialize(params)
    @token_id = params[:token_id]
    @input_token = params[:input_token]
    @provider = params[:provider]
    @email = params[:email]
    @name = params[:name]
  end

  # rubocop:disable Metrics/MethodLength
  def execute
    if @provider.blank?
      return { success: false, errors: {
        provider_not_found: 'Provider param can not be empty'
      } }
    end
    user = select_provider
    if user.blank?
      return { success: false, errors: {
        user_empty: 'User can not be empty'
      } }
    end
    { success: true, payload: { user: user, token: @token } }
  end
  # rubocop:enable Metrics/MethodLength

  private

  def select_provider
    return google_login if @provider == 'google'

    facebook_login if @provider == 'facebook'
  end

  def google_login
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{@token_id}"
    response = HTTP.follow.get(url)
    user = User.first_or_initialize_for_google(JSON.parse(response.to_s))
    @token = user.create_new_auth_token
    user.save
    user
  end

  def facebook_login
    params = "input_token=#{@input_token}&access_token=#{access_token_facebook}"
    url = "https://graph.facebook.com/debug_token?#{params}"
    response = HTTP.follow.get(url)
    create_user_facebook if response.status == 200
  end

  def access_token_facebook
    fb_key = ENV['FACEBOOK_KEY']
    fb_secret = ENV['FACEBOOK_SECRET']
    params = "client_id=#{fb_key}&client_secret=#{fb_secret}"
    type = 'grant_type=client_credentials'
    url = "https://graph.facebook.com/oauth/access_token?#{params}&#{type}"
    response = HTTP.follow.get(url)
    JSON.parse(response.to_s)['access_token']
  end

  def create_user_facebook
    user = User.first_or_initialize_for_facebook(@email, @name)
    @token = user.create_new_auth_token
    user.save
    user
  end
end
