class AllTotalMonthlyFeeService
  def initialize(date:)
    @date = date
  end

  def call
    Merchant.all.each do |merchant|
      TotalMonthlyFeeService.new(merchant: merchant, date: date).call
    end
  end

  private

  attr_reader :date
end
