# frozen_string_literal: true

class RoomController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize :room
    room = Room.new(room_params)
    room.save!
    result = generate_token(room)
    if result[:success]
      render status: :created, json: result[:room]
    else
      render status: :unprocessable_entity, json: result[:errors]
    end
  end

  def access
    new_room = Room.find(params[:id])
    authorize new_room
    remove_user_from_actual_room if current_user.room_id?
    new_room.users.append(current_user)
    render json: new_room
  end

  private

  def room_params
    params.require(:room).permit!
  end

  def remove_user_from_actual_room
    Room.find(current_user.room_id).users.delete(current_user)
  end

  def generate_token(room)
    GenerateRoomToken.execute(room, current_user)
  end
end
