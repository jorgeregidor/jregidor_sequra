class CreateMerchants < ActiveRecord::Migration[7.2]
  def change
    create_table :merchants, id: :uuid do |t|
      t.string :reference, null: false, index: { unique: true }
      t.string :email
      t.date :live_on, null: false
      t.string :disbursement_frequency, null: false, index: true
      t.integer :disbursement_wday
      t.integer :minimum_monthly_fee_cents
      t.timestamps
    end
  end
end
