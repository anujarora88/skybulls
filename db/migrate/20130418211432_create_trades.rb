class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :stock_id
      t.integer :amount
      t.money :price
      t.integer :user_league_association_id
      t.string :type

      t.foreign_key :user_league_associations
      t.foreign_key :stocks


      t.timestamps
    end
  end
end
