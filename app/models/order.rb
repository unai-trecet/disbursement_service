class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  has_one :disbursement

  monetize :amount_cents, as: :amount

  validates :merchant_id, :shopper_id, :amount_cents, presence: true
end
