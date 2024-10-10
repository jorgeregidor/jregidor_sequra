class DailyJob < ApplicationJob
  queue_as :default

  def perform(values = {})
    date = values[:date] ||= Date.today

    DailyJobService.new(date: date).call
  end
end
