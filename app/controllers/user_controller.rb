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

  # rubocop:disable Metrics/AbcSize
  def update
    user = User.find(params[:id])
    authorize user
    user.update(user_params) if params[:user].present?
    update_mood(user) if params[:mood].present?
    update_status(user) if params[:status].present?
    render status: :ok, json: user
  end
  # rubocop:enable Metrics/AbcSize

  def leave_rooms
    user = User.find(params[:id])
    user.update(room_id: nil)
    render status: :ok, json: user
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def update_mood(user)
    mood = params[:mood][:name]
    new_mood = Mood.find_by(name: mood)
    user.update(mood: new_mood)
  end

  def update_status(user)
    new_status = Status.find_by(status: params[:status][:status])
    user.update(status: new_status)
  end
end
