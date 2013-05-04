class CleanupDb < ActiveRecord::Migration
  def change

    change_column :user_league_associations, :league_id, :null => false
    change_column :user_league_associations, :user_id, :null => false

    add_foreign_key :user_league_associations, :users
    add_foreign_key :user_league_associations, :leagues

    remove_column :leagues, :description
    remove_column :leagues, :market
    change_column :leagues, :title, :null => false
    change_column :leagues, :category, :null => false
    change_column :leagues, :buy_in, :null => false
    change_column :leagues, :commission, :null => false
    change_column :leagues, :start_time, :null => false
    change_column :leagues, :end_time, :null => false

  end
end
