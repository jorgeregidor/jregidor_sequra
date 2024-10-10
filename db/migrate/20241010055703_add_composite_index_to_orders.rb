class AddCompositeIndexToOrders < ActiveRecord::Migration[7.2]
  def change
    add_index :orders, [ :disbursement_reference, :order_date, :merchant_reference ]
  end
end
