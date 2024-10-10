namespace :orders_history do
  desc "Create disbursement for orders"
  task create_disbursements: :environment do
    puts "Creating disbursements for orders history"
    start_date  = Order.not_completed.minimum(:order_date)
    end_date = Order.not_completed.maximum(:order_date)

    (start_date..end_date).each do |date|
      puts "Creating disbursement for #{date}"
      DailyJob.perform_now(date)
    end
    puts "Finished creating disbursements for orders history"
  end
end
