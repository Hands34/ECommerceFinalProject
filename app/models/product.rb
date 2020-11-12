class Product < ApplicationRecord
  belongs_to :category

  # has_one :product_order

  validates :product_name, :price, :description, presence: true

  validates :price, numericality: true

  self.inheritance_column = "not_sti"

  def self.search(search)
    if search
      where(["product_name LIKE ?", "%#{search}%"])
    else
      all
    end
  end
end
