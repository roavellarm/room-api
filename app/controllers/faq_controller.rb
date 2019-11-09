# frozen_string_literal: true

class FaqController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def index
    render status: :ok, json: Faq.all.order(sorting: :asc, created_at: :desc)
  end
end
