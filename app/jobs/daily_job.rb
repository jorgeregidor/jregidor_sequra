class DailyJob < ApplicationJob
  queue_as :default

  def perform(date)
    DailyDisbursementsService.new(date: date).call
  end
end
