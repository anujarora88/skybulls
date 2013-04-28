class CreateUsersUserStockAssociations < ActiveRecord::Migration
  def change
    create_table :users_user_stock_associations do |t|
      t.integer :user_id
      t.integer :stock_id
      t.boolean :recently_searched

      t.timestamps
    end

    add_index :users_user_stock_associations, [:user_id,:stock_id], :unique => true
  end
end
