class AllTotalMonthlyFeeService
  def initialize(date:)
    @date = date
  end

  def call
    Merchant.by_live_on_before(date).each do |merchant|
      TotalMonthlyFeeService.new(merchant: merchant, date: date).call
    end
  end

  private

  attr_reader :date
end
