# frozen_string_literal: true

class UserController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def index
    render status: :ok, json: User.all.order(first_name: :asc, last_name: :asc)
  end
end
