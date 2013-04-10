class UpdateStockTable < ActiveRecord::Migration
  def up
    add_column :stocks , :user_id, :integer
    add_column :stocks , :exchange_id, :integer
  end

  def down
  end
end
