class DropProvinces < ActiveRecord::Migration[6.0]
  def change
    drop_table :provinces
  end
end
