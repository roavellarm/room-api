# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize :chat
    chat = Chat.new(chat_params)
    chat.user = current_user
    chat.save!
    render status: :created, json: chat
  end

  def show
    authorize :chat
    messages = Chat.where(room_id: params[:id]).order(created_at: :asc)
    render json: messages.as_json
  end

  private

  def chat_params
    params.require(:chat).permit!
  end
end
