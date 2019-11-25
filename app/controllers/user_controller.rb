# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :user
    render status: :ok, json: User.all.order(first_name: :asc, last_name: :asc)
  end

  def change_mood
    new_mood = Mood.find_by(name: params[:mood])
    authorize :user
    user = current_user
    user.update!(mood: new_mood)
    render status: :ok, json: user
  end
end
