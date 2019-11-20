# frozen_string_literal: true

class RoomController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize :room
    room = Room.new(permitted_params)
    room.save!
    result = generate_token(room)
    if result[:success]
      render status: :created, json: result[:room]
    else
      render status: :unprocessable_entity, json: result[:errors]
    end
  end

  private

  def permitted_params
    params.require(:room).permit!
  end

  def generate_token(room)
    GenerateRoomToken.execute(room: room, user: current_user)
  end
end
