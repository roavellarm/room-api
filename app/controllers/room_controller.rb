# frozen_string_literal: true

class RoomController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

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
