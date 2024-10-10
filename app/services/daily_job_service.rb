class DailyJobService
  def initialize(date:)
    @date =  date
  end

  def call
    DailyDisbursementsService.new(date: date).call
    AllTotalMonthlyFeeService.new(date: date).call if date.day == 1
  end

  attr_reader :date
end
