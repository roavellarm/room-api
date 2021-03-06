# frozen_string_literal: true

class GenerateRoomToken
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

  def initialize(room, current_user)
    @user = current_user
    @room = room
  end

  def execute
    @new_token = generate_token
    return error if token_already_exist

    success
  end

  private

  # rubocop:disable Metrics/AbcSize
  def generate_token
    (number_name(@user.id) + @user.first_name + @user.last_name +
     number_name(@room.org_id) + @room.org.name + number_name(@room.id) +
     @room.title).gsub(/\s+/, '').downcase.reverse!
  end
  # rubocop:enable Metrics/AbcSize

  def write_number(digit)
    numbers = %w[zero one two three four five six seven eight nine]
    numbers[digit.to_i]
  end

  def number_name(num)
    splitted_number = num.to_s.split('')
    result = ''
    splitted_number.each do |digit|
      result += write_number(digit)
    end
    result
  end

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
    @room.update(token: @new_token)
    { success: true, room: @room }
  end
end
