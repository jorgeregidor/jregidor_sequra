class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :custom_id, null: false, index: {unique: true}
      t.string :merchant_reference, null: false, index: true
      t.integer :amount_cents, default: 0, null: false
      t.date :order_date, null: false, index: true
      t.string :disbursement_reference
      t.timestamps
    end
  end
end
