# frozen_string_literal: true

class OrgController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :org
    render status: :ok, json: Org.all.order(name: :asc)
  end
end
