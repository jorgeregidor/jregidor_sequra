require 'csv'
require 'securerandom'

# Merchants seeds from csv
CSV.foreach(Rails.root.join("db/seeds/csv/merchants.csv"), headers: true, col_sep: ';') do |row|
  begin
    date = Date.strptime(row['live_on'], '%Y-%m-%d')
  rescue TypeError
    puts "Invalid date format for #{row['live_on']}"
    next
  end

  Merchant.create(
    id: row['id'],
    reference: row['reference'],
    email: row['email'],
    live_on: date,
    disbursement_frequency: row['disbursement_frequency'],
    disbursement_wday: date.wday,
    minimum_monthly_fee_cents: (row['minimum_monthly_fee'].to_f * 100).to_i
  )
end
p 'Created merchants'


# Orders seeds from csv
def create_orders
  orders = []
  time_now = Time.now
  order_count = 0
  CSV.foreach(Rails.root.join("db/seeds/csv/orders.csv"), headers: true, col_sep: ';') do |row|
    order_count += 1
    begin
      date = Date.strptime(row['created_at'], '%Y-%m-%d')
    rescue TypeError
      puts "Invalid date format for #{row['created_at']}"
      next
    end

    orders << {
      custom_id: row['id'],
      merchant_reference: row['merchant_reference'],
      amount_cents: (row['amount'].to_f * 100).to_i,
      order_date: date,
      created_at: time_now,
      updated_at: time_now
    }

    if order_count % 50000 == 0
      Order.insert_all(orders)
      orders = []
      p "Created #{order_count} orders, still creating..."
    end
  end
  Order.insert_all(orders) if orders.any?
  p 'Created all orders'
end

create_orders
