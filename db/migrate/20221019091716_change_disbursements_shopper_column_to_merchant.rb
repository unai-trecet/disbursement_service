class ChangeDisbursementsShopperColumnToMerchant < ActiveRecord::Migration[7.0]
  def change
    remove_column :disbursements, :shopper_id
    add_reference :disbursements, :merchant, null: false, foreign_key: true
  end
end
