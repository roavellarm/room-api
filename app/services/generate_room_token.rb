# frozen_string_literal: true

class GenerateRoomToken
  def self.execute(**keywords, &block)
    new(**keywords, &block).execute
  end

  def initialize(params)
    @user = params[:user]
    @room = params[:room]
  end

  def execute
    @new_token = generate_token
    return error if token_already_exist

    success
  end

  private

  # rubocop:disable Metrics/AbcSize
  def generate_token
    (@user.id.to_s + @user.first_name + @user.last_name + @room.org_id.to_s +
     @room.org.name + @room.id.to_s + @room.title)
      .gsub(/\s+/, '').downcase.reverse!
  end
  # rubocop:enable Metrics/AbcSize

  def token_already_exist
    is_the_token_taken = false
    Room.all.each { |x| is_the_token_taken = true if x.token == @new_token }

    is_the_token_taken
  end

  def error
    Room.find_by(id: @room.id).destroy!
    { success: false,
      errors: { id: 'unprocessable_entity',
                message: 'Token has already been taken' } }
  end

  def success
    @room.update!(token: @new_token)
    { success: true, room: @room }
  end
end
