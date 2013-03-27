class CreateUserLeagues < ActiveRecord::Migration
  def change
    create_table :user_leagues do |t|
      t.integer :user_id
      t.integer :league_id

      t.timestamps
    end
  end
end
