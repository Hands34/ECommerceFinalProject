class Order < ApplicationRecord
  belongs_to :customer
  has_one :product_order
end
