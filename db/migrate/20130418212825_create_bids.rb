class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_league_association_id
      t.string :type
      t.integer :stock_id
      t.integer :amount
      t.integer :trade_id

      t.money :price

      t.foreign_key :user_league_associations
      t.foreign_key :stocks
      t.foreign_key :trades


      t.timestamps
    end
  end
end
