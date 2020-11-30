class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :email, presence: true
end
