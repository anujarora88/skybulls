class RenameUserStockAssociation < ActiveRecord::Migration
  def up
    rename_table :users_user_stock_associations, :user_stock_associations
  end

  def down
  end
end
