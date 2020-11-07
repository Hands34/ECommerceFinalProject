class Province < ApplicationRecord
  has_many :customers

  validates :name, :tax_rate, presence: true

  validates :tax_rate, numericality: { only_integer: true }
end
