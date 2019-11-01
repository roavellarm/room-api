# frozen_string_literal: true

class AdminTextsController < ApplicationController
  def index
    texts = []

    return render status: :bad_request if params[:tags].blank?

    params[:tags].each do |tag|
      texts << { "#{tag}": AdminText.find_by(field: tag)&.text }
    end

    render json: texts
  end
end
