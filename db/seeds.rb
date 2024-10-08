# Merchants seeds from csv
require 'csv'

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
