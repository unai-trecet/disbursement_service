class Merchant < ApplicationRecord
  has_many :orders

  validates :name, :email, :cif, presence: true
end
