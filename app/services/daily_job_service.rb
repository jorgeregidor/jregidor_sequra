class DailyJobService
  def initialize(date:)
    @date =  date
  end

  def call
    DailyDisbursementsService.new(date: date).call
    AllTotalMonthlyFeeService.new(date: date - 1.day).call if date.day == 1
  end

  attr_reader :date
end
