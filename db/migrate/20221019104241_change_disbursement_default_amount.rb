class ChangeDisbursementDefaultAmount < ActiveRecord::Migration[7.0]
  def change
    remove_monetize :disbursements, :amount
    add_monetize :disbursements, :amount, amount: { null: true, default: nil }
  end
end
