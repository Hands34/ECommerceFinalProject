class Product < ApplicationRecord
  belongs_to :category

  # has_one :product_order

  validates :product_name, :price, :description, presence: true

  validates :price, numericality: true
end
