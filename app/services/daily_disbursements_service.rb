class DailyDisbursementsService
  def initialize(date)
    @date = date
  end

  def call
    merchants = find_merchants
    orders = find_orders(merchants)
    grouped_orders = orders.group_by(&:merchant_reference)

    merchants.each do |merchant|
      merchant_orders = grouped_orders[merchant.reference]
      next if merchant_orders.nil?

      # DisbursementService.new(merchant, indexed_orders[merchant.reference]).call
    end
  end

  private

  def find_merchants
    Merchant.weekly.or(Merchant.weekly_by_wday(date.wday))
  end

  def find_orders(merchants)
    Order.by_date(date).not_completed.by_merchant(merchants.pluck(:reference))
  end

  attr_reader :date
end
