# frozen_string_literal: true

class OrgController < ApplicationController
  before_action :authenticate_user!

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

  def show
    org = Org.find(params[:id])
    authorize org
    render json: org
  end

  def add_member
    authorize :org
    user = User.find_by(email: params[:email])
    org = Org.find(params[:id])
    org.members.append(user)
    render status: :ok, json: org
  end

  private

  def permitted_params
    params.require(:org).permit!
  end
end
