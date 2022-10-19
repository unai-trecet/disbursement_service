class ChangeOrdersDefaultAmount < ActiveRecord::Migration[7.0]
  def change
    remove_monetize :orders, :amount
    add_monetize :orders, :amount, amount: { null: true, default: nil }
  end
end
