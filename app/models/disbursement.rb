class Disbursement < ApplicationRecord
  belongs_to :shopper
  belongs_to :order
end
