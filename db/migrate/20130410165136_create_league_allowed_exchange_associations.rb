class CreateLeagueAllowedExchangeAssociations < ActiveRecord::Migration
  def up
    create_table :exchanges_leagues, :id => false do |t|
      t.integer  :exchange_id
      t.integer :league_id

      t.timestamps
    end
    add_index :exchanges_leagues, [:exchange_id, :league_id], :unique => true
  end

  def down
  end
end
