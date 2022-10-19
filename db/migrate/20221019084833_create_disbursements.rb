class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.references :shopper, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.monetize :amount
      t.datetime :completed_at

      t.timestamps
    end
  end
end
