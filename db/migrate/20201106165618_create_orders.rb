class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.double :total_price
      t.double :tax
      t.double :price
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
