# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :leave_rooms
  skip_after_action :verify_authorized, only: :leave_rooms

  def index
    authorize :user
    render status: :ok, json: User.all.order(first_name: :asc, last_name: :asc)
  end

  def show
    user = User.find(params[:id])
    authorize user
    render json: user
  end

  def update
    user = User.find(params[:id])
    authorize user
    user.update!(user_params) if params[:user].present?
    update_mood(user) if params[:mood].present?
    render status: :ok, json: user
  end

  def leave_rooms
    user = User.find(params[:id])
    user.update!(room_id: nil)
    render status: :ok, json: user
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def update_mood(user)
    new_mood = Mood.find_by(name: params[:mood])
    user.update!(mood: new_mood)
  end
end
