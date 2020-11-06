class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.float :total_price
      t.float :tax
      t.float :price
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
