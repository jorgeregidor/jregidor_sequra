class CreateTotalMonthlyFees < ActiveRecord::Migration[7.2]
  def change
    create_table :total_monthly_fees do |t|
      t.string :merchant_reference, null: false, index: true
      t.date :date, null: false
      t.integer :amount_cents, default: 0
      t.boolean :reached, default: false

      t.timestamps
    end
  end
end
