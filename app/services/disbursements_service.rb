class DisbursementsService
  def initialize(date:, merchant:, orders:)
    @date = date
    @merchant = merchant
    @orders = orders
  end

  def call
    total_merchant_amount_cents = 0
    total_commision_amount_cents = 0

    orders.each do |order|
      order_commision_amount_cents = calculate_commision_amount_cents(order.amount_cents)

      total_commision_amount_cents += order_commision_amount_cents
      total_merchant_amount_cents += (order.amount_cents - order_commision_amount_cents)
    end

    disbursement = Disbursement.create(
      merchant_reference: merchant.reference,
      merchant_amount_cents: total_merchant_amount_cents,
      commision_amount_cents: total_commision_amount_cents,
      disbursement_date: date
    )

    update_orders(disbursement)
  end

  private

  def calculate_commision_amount_cents(amount_cents)
    ComissionService.new(amount_cents: amount_cents).call
  end

  def update_orders(disbursement)
    Order.by_ids(orders.pluck(:id)).update_all(disbursement_reference: disbursement.id)
  end

  attr_reader :date
  attr_reader :merchant
  attr_reader :orders
end
