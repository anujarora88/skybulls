class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.float :latest_price

      t.timestamps
    end
  end
end
