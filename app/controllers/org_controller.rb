# frozen_string_literal: true

class OrgController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :org
    user = current_user
    orgs = user.orgs.concat(user.orgs_as_member).order(name: :asc)
    render status: :ok, json: orgs
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

  # rubocop:disable Metrics/AbcSize
  def add_member
    org = Org.find(params[:id])
    authorize org
    user = User.find_by(email: params[:email])
    return user_not_register if user.nil?
    return already_member if org.members.include?(user)

    org.members.append(user)
    render status: :ok, json: org.as_json
  end
  # rubocop:enable Metrics/AbcSize

  private

  def permitted_params
    params.require(:org).permit!
  end

  def already_member
    render status: :unprocessable_entity, json: error_message.to_json
  end

  def user_not_register
    render status: :not_found, json: error_message2.to_json
  end

  def error_message
    { success: false,
      errors: { id: 'unprocessable_entity',
                message: 'The user is already a member of this org' } }
  end

  def error_message2
    { success: false,
      errors: { id: 'not_found',
                message: 'The user is not registered already in the app' } }
  end
end
