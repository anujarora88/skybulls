class CreateLeagueAllowedExchangeAssociations < ActiveRecord::Migration
  def up
    create_table :league_exchange_associations do |t|
      t.integer  :exchange_id
      t.foreign_key :exchange , :column_name => :exchange_id
      t.integer :league_id
      t.foreign_key  :league , :column_name => :league_id

      t.timestamps
    end
  end

  def down
  end
end
