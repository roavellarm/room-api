# frozen_string_literal: true

class OrgController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def index
    authorize :org
    render status: :ok, json: Org.all.order(name: :asc)
  end

  def create
    authorize :org
    org = Org.new(permitted_params)
    org.save!
    render status: :created, json: org
  end

  private

  def permitted_params
    params.require(:org).permit!
  end
end
