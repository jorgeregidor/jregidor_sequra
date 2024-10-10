class TotalMonthlyFeeService
  def initialize(merchant:, date:)
    @merchant = merchant
    @first_month_day = date.beginning_of_month
    @last_month_day = date.end_of_month
  end

  def call
    total_commision_amount_cents = Disbursement.by_merchant(merchant.reference)
      .by_date_range(first_month_day, last_month_day)
      .sum(:commision_amount_cents)

    reached = total_commision_amount_cents >= merchant.minimum_monthly_fee_cents

    TotalMonthlyFee.create(
      merchant_reference: merchant.reference,
      date: first_month_day,
      amount_cents: total_commision_amount_cents,
      reached: reached
    )
  end

  private

  attr_reader :merchant
  attr_reader :first_month_day
  attr_reader :last_month_day
end
