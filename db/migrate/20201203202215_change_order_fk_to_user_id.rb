class ChangeOrderFkToUserId < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :user_id, :integer
  end
end
