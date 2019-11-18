# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :user
    render status: :ok, json: User.all.order(first_name: :asc, last_name: :asc)
  end
end
