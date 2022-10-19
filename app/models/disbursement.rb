class Disbursement < ApplicationRecord
  belongs_to :merchant
  belongs_to :order
  
  monetize :amount_cents, as: :amount

  validates :order_id, :merchant_id, :amount_cents, presence: true
end
