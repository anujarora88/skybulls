class AddMoneySupportToStocks < ActiveRecord::Migration
  def change
    remove_column :stocks, :latest_price
    add_money :stocks, :latest_price
  end
end
