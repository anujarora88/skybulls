class CreateLeagueAllowedExchangeAssociations < ActiveRecord::Migration
  def up
    create_table :exchanges_leagues do |t|
      t.integer  :exchange_id
      t.foreign_key :exchanges , :column_name => :exchange_id
      t.integer :league_id
      t.foreign_key  :leagues , :column_name => :league_id

      t.timestamps
    end
  end

  def down
  end
end
