class AnalyticsController < ApplicationController
  def index
    response = analytics_repository.read
    render json: response.to_json, status: 200
  end

  private

  def analytics_repository
    AnalyticsRepository.new
  end
end
