class Shopper < ApplicationRecord
  validates :name, :email, :nif, presence: true
  has_many :orders
end
