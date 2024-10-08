class CreateDisbursements < ActiveRecord::Migration[7.2]
  def change
    create_table :disbursements, id: :uuid do |t|
      t.string :merchant_reference, null: false, index: true
      t.integer :merchant_amount_cents, default: 0, null: false
      t.integer :commision_amount_cents, default: 0, null: false
      t.date :disbursement_date, null: false

      t.timestamps
    end
  end
end
