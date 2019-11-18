# frozen_string_literal: true

class RoomController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize :room
    room = Room.new(permitted_params)
    room.save!
    render status: :created, json: room
  end

  private

  def permitted_params
    params.require(:room).permit!
  end
end
