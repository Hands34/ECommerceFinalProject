class Order < ApplicationRecord
  belongs_to :customer
  has_one :product_order

  validates :total_price, :tax, :price, presence: true

  validates :total_price, :tax, :price, numericality: { only_float: true }
end
