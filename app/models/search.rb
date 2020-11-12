class Search < ApplicationRecord
  self.inheritance_column = "not_sti"

  def search_product
    product = Product.all

    product = product.where(["product_name LIKE ?", product_name]) if product_name.present?
    product = product.where(["category_id LIKE ?", category_id]) if category_id.present?
    product = product.where(["company LIKE ?", company]) if company.present?

    product
  end
end
