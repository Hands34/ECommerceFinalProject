class Order < ApplicationRecord
  belongs_to :user
  has_one :product_order

  validates :total_price, :tax, presence: true

  validates :total_price, :tax, numericality: { only_float: true }
end
