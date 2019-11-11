# frozen_string_literal: true

class FeedbackController < ApplicationController
  skip_after_action :verify_authorized

  def create
    feedback = Feedback.new(permitted_params)
    feedback.save!
    render status: :created, json: feedback
  end

  private

  def permitted_params
    params.require(:feedback).permit!
  end
end
